# Domain
    @team -< @user    -< @address
@category -< @ranking -< @selection >- @player 

# Associations: 

**Ranking**
has_many :selections
has_many :players, through: selections

**Selection**
belongs_to :ranking
belongs_to :player

**Player**
has_many :teams

# Attributes

**Ranking**
\* description

$ rails g resource Ranking description:text

**Selection**
\* rank_position
\* ranking_id
\* player_id

$ rails g model Selection ranking_position:string ranking_id:integer player_id:integer ranking:belongs_to player:belongs_to

**Player**
\* name
\* position
\* number

$ rails g resource Player name position number:integer


# ranking_params

ranking = [
    description: "This is my description",
    
    selections_attributes: [
        { rank_position: "1", player_id: 7 },
        { rank_position: "2", player_id: 15 },
        { rank_position: "3", player_id: 11 },
        { rank_position: "4", player_id: 23 },
        { rank_position: "5", player_id: 33 },
        
        player_ids: [],
        player_attributes: [
            { name: "", position: "", number: 0, team_id: 2 },
        ]
    ],
]

# ranking_params 2
ranking = [
    description: "This is my description",
    
    selections_attributes: [
        { rank_position: "1", player_id: 7 },
        { rank_position: "2", player_id: 15 },
        { rank_position: "3", player_id: 11 },
        { rank_position: "4", player_id: 23 },
        { rank_position: "5", player_id: 33 },
        
        player_ids: [],
        player_attributes: [
            { name: "", position: "", number: 0, team_id: 2 },
            
            year_ids: [],
            years_attributes: [
                { city: "", name: "", year: 0000, sport_id: 5},
                
                sport_ids: []
                sport_attributes: [
                    { name: "Basketball" }
                ]
            ],
        ]
    ],
]

########################################################################################################


# REFACTOR: 1   => [Category]

@category -< @ranking -< @selection >- @player 


# Added Associations:
                                                
**Category**
has_many :rankings

**Ranking**
belongs_to :category


# Added Attributes:

**Category**
\* title

$ rails g resource Category title

**Ranking**
\* category_id

$ rails g migration AddCategoryIndexToRankings category_id:integer category:belongs_to 


########################################################################################################


# REFACTOR: 2   => [User, Comment]

              @user
                |
                ^
             @comment
                v                                                      
                |
@category -< @ranking -< @selection >- @player


# Added Associations

**User**
has_many :comments
has_many :rankings, through: :comments

**Comment**
belongs_to :user
belongs_to :ranking


# Added Attributes

**User**
\* username
\* email
\* password_digest

$ rails g resource User username email password_digest

**Comment**
\* context
\* user_id
\* ranking_id

$ rails g resource Comment context:text user_id:integer ranking_id:integer user:belongs_to ranking:belongs_to


########################################################################################################


# REFACTOR: 3   => [Year, Team]

              @user
                |           
                ^
             @comment
                v
                |
@category -< @ranking -< @selection >- @player -< @year >- @team


# Added Associations:

**Player**
has_many :years
has_many :teams, through: :years

**Year**
belongs_to :player
belongs_to :team

**Team**
has_many :years
has_many :players, through: :years


# Added Atrributes

**Player**
\* team_id

$ rails g migration AddTeamIndexToPlayers team_id:integer team:belongs_to

**Team**
\* city
\* name
\* year

$ rails g resource Team city name year:integer


########################################################################################################


# REFACTOR: 4   => [Sport]

                        @user
                          |           
                          ^
                      @comment
                          v
                          |
@sport -< @category -< @ranking -< @selection >- @player -< @year >- @team >- @sport
    

# Added Associations
**Sport**
has_many :categories
has_many :teams

**Team**
belongs_to :sport


# Added Attributes

**Sport**
\* name

$ rails g resource Sport name

**Team**
\* sport_id

$ rails g migration AddSportIdToTeams sport_id:integer sport:belongs_to


########################################################################################################


# REFACTOR: 5   => [Sneaker, Brand]

              @user
                |           
                ^
             @comment
                v
                |
@category -< @ranking -< @selection >- @player -< @years >- @team >- @sport
                                          |
                                          ^
                                       @sneaker
                                          v
                                          |
                                        @brand

# Added Associations

**Player**
has_many :sneakers
has_many :brands, through: :sneakers

**Sneaker**
belongs_to :player
belongs_to :brand

**Brand**
has_many :sneakers
has_many :players, through: :sneakers


# Added Attributes

**Sneaker**
\* name
\* release_date
\* player_id
\* brand_id

$ rails g resource name release_date:integer player_id:integer brand_id:integer player:belongs_to brand:belongs_to

*Brand*
\* name


########################################################################################################


# REFACTOR: 6   => [ColorWay]

              @user
                |           
                ^
             @comment
                v
                |
@category -< @ranking -< @selection >- @player >- @team >- @sport
                                               |
                                               ^
                                            @sneaker -< @color_way
                                               v
                                               |
                                             @brand

# Added Associations

**Sneaker**
has_many :color_ways

**ColorWay**
belongs_to :sneaker


# Added Attributes

**ColorWay**
\* primary
\* secondar
\* tertiary
\* material
\* sneaker_id

$ rails g model ColorWay primary secondary tertiary material sneaker_id:integer sneaker:belongs_to


########################################################################################################


# REFACTOR: 7   => [Coach]

              @user                                             
                |                                                 
                ^                                        
             @comment                                 @coach
                v                                        |
                |                                        ^
@category -< @ranking -< @selection >- @player >- @team >- @sport
                                               |
                                               ^
                                           @sneaker -< @color_way
                                               v
                                               |
                                            @brand

# Added Associations

**Coach**
has_many :teams

**Team**
belongs_to :coach


# Added Attributes

**Coach**
\* name

$ rails g resource Coach name 

**Team**
\* coach_id

$ rails g migration AddCoachIndexToTeams coach_id:integer coach:belongs_to


########################################################################################################


# REFACTOR: 7   => [League]

              @user
                |
                ^
             @comment                                          @coach
                v                                                 |
                |                                                 ^
@category -< @ranking -< @selection >- @player -< @year >- @team >- @sport
                                               |                            |
                                               ^                            ^
                                            @sneaker -< @color_way       @league
                                               v
                                               |
                                             @brand

# Added Associatons

**Sport**
has_many :leagues

**League**
belongs_to :sport


########################################################################################################


#                                       Scalability


########################################################################################################

                        @user
                          |        
                          ^
                       @comment
                          v                      
                          |                   =<  @select_person  >= @person
@genre -< @category -< @ranking -< @selection =<  @select_place   >= @place
                                              =<  @select_thing   >= @thing
                               

Project Structure
=================

## Directory Structure

```
beautefly-webstore
├── deploy/              # Files used for deployment
├── docs/                # Developer documentations for detailing the project architecture, standards & conventions, usage, etc.
├── src
│   ├── main
│   │   ├── java         # Java source code
│   │   ├── resources    # Configurations
│   │   └── webapp       # Web related files (.html, .jsp, .css, .js)
│   └── tests
├── .dockerignore
├── .gitattributes
├── .gitignore
├── .env                 # Preset environment variables for deploying the application
├── docker-compose.yml   # Compose configuration for deployment
├── Dockerfile           # For building the web application docker image
├── README.md
├── LICENSE
└── pom.xml              # Project's maven configuration and depedencies
```

## Package Structure

### Files Structuring

This project prefers **group by features** as opposed to group by types.

Java classes are grouped into directories with similar features, and if needed, grouped by types within each feature.

Example,

```
└── src
    └── main
        ├── user
        │   ├── UserServlet
        │   ├── UserController
        │   ├── UserRepository
        │   ├── entity         # additional group by type if suitable
        │   │   ├── User
        │   │   └── UserRole
        │   └── dto
        │       ├── UserBaseDTO
        │       ├── UserRegisterDTO
        │       └── UserLoginDTO
        ├── order
        ├── security
        └── payment
```

### Class Naming and Roles

As you have seen, in each feature module, there are multiple java class with nouns such as User**Controller** and
User**Repository**.

Each of this noun specific the role and the function of the class.

Here is a list of nouns typically used in this project,

| Noun       | Function                                                                                                 |
|------------|----------------------------------------------------------------------------------------------------------|
| Repository | Perform basic CRUD operations between the web application and database.                                  |
| Controller | Defines the api endpoints. Process users interaction with the web application.                           |
| Entity     | Defines the object's schema and datatype in a database.                                                  |
| DTO        | Specify the data shape and format when accepting user input.                                             |
| Service    | Implements business logics. Commonly used logic to be used by other classes like Controller and Servlet. |
| Servlet    | Defines the view endpoints. Serve HTML webpage.                                                          |
| Config     | Configures environment and variables.                                                                    |
| Exception  | Custom exceptions.                                                                                       |



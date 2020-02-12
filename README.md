# World Cup

### Ruby version
2.6.4

### Rails version
6.0.2.1

### System dependencies
Postgresql

### Configuration
```
bundle install
yarn install
```

### Database creation
`rails db:create`

### Database initialization
```
rails db:migrate
rails db:seed
```

### How to run the test suite
`bundle exec rspec`

### Run the API server
`rails server`

### Documentation
Input endpoint set a list of teams by name and works
just before the first phase, and then begins the first phase.

POST
`localhost:3000/api/teams`

```json
{
	"team1": "brazil",
	"team2": "south africa",
	"team3": "argentina",
	"team4": "colombia",
	"team5": "japan",
	"team6": "netherlands",
	"team7": "france",
	"team8": "germany",
	"team9": "italy",
	"team10": "england",
	"team11": "spain",
	"team12": "uruguay"
}
```

```json
{
    "status": "SUCCESS",
    "message": "Team Succcessfully Saved"
}
```
Input endpoint to receive game results, the matches
are referenced by ID, a batch of results is sent in
a single request, only matches of the current phase
are allowed to be sent.

POST
`localhost:3000/api/results`
```json
{
	"matches": [
		{
			"id": 1,
			"team_a_goals": 7,
			"team_b_goals": 1
		},
		{
			"id": 12,
			"team_a_goals": 1,
			"team_b_goals": 0
		}
	]
}
```

```json
{
    "status": "SUCCESS",
    "message": "Result Succcessfully Saved"
}
```

Read endpoint to get the state of the tournament,
current phase [none, first, second, semifinal, final], list
of teams with IDs, next matches and played matches.

GET
`localhost:3000/api/states_tournament`
```json
{
    "status": "SUCCESS",
    "message": "State Tournament Succcessfully Loaded",
    "data": [
        {
            "id": 1,
            "name": "World Cup",
            "state": "first",
            "teams": [
                {
                    "id": 3,
                    "name": "argentina"
                },
                {
                    "id": 7,
                    "name": "france"
                },
                {
                    "id": 8,
                    "name": "germany"
                },
                {
                    "id": 1,
                    "name": "brazil"
                },
                {
                    "id": 4,
                    "name": "colombia"
                },
                {
                    "id": 5,
                    "name": "japan"
                },
                {
                    "id": 2,
                    "name": "south africa"
                },
                {
                    "id": 6,
                    "name": "netherlands"
                },
                {
                    "id": 9,
                    "name": "italy"
                },
                {
                    "id": 10,
                    "name": "england"
                },
                {
                    "id": 11,
                    "name": "spain"
                },
                {
                    "id": 12,
                    "name": "uruguay"
                }
            ],
            "next_matches": [
                {
                    "id": 2,
                    "played": false,
                    "team_a": 3,
                    "team_b": 8,
                    "phase": 1
                },
                {
                    "id": 3,
                    "played": false,
                    "team_a": 7,
                    "team_b": 8,
                    "phase": 1
                },
                {
                    "id": 4,
                    "played": false,
                    "team_a": 1,
                    "team_b": 4,
                    "phase": 1
                },
                {
                    "id": 5,
                    "played": false,
                    "team_a": 1,
                    "team_b": 5,
                    "phase": 1
                },
                {
                    "id": 6,
                    "played": false,
                    "team_a": 4,
                    "team_b": 5,
                    "phase": 1
                },
                {
                    "id": 9,
                    "played": false,
                    "team_a": 6,
                    "team_b": 9,
                    "phase": 1
                },
                {
                    "id": 10,
                    "played": false,
                    "team_a": 10,
                    "team_b": 11,
                    "phase": 1
                },
                {
                    "id": 11,
                    "played": false,
                    "team_a": 10,
                    "team_b": 12,
                    "phase": 1
                }
            ],
            "played_matches": [
                {
                    "id": 1,
                    "played": true,
                    "team_a": 3,
                    "team_b": 7,
                    "phase": 1
                },
                {
                    "id": 7,
                    "played": true,
                    "team_a": 2,
                    "team_b": 6,
                    "phase": 1
                },
                {
                    "id": 8,
                    "played": true,
                    "team_a": 2,
                    "team_b": 9,
                    "phase": 1
                },
                {
                    "id": 12,
                    "played": true,
                    "team_a": 11,
                    "team_b": 12,
                    "phase": 1
                }
            ]
        }
    ]
}
```

Read endpoint of ranking, ranking is a list of teams,
IDs and positions.

GET
`localhost:3000/api/rankings`
```json
{
    "status": "SUCCESS",
    "message": "Ranking Succcessfully Loaded",
    "data": [
        {
            "id": 3,
            "total_goals": 7,
            "results": {
                "win": 1,
                "defeat": 0,
                "draw": 0
            }
        },
        {
            "id": 2,
            "total_goals": 6,
            "results": {
                "win": 1,
                "defeat": 1,
                "draw": 0
            }
        },
        {
            "id": 6,
            "total_goals": 2,
            "results": {
                "win": 1,
                "defeat": 0,
                "draw": 0
            }
        },
        {
            "id": 11,
            "total_goals": 1,
            "results": {
                "win": 1,
                "defeat": 0,
                "draw": 0
            }
        },
        {
            "id": 7,
            "total_goals": 1,
            "results": {
                "win": 0,
                "defeat": 1,
                "draw": 0
            }
        },
        {
            "id": 12,
            "total_goals": 0,
            "results": {
                "win": 0,
                "defeat": 1,
                "draw": 0
            }
        },
        {
            "id": 10,
            "total_goals": 0,
            "results": {
                "win": 0,
                "defeat": 0,
                "draw": 0
            }
        },
        {
            "id": 9,
            "total_goals": 0,
            "results": {
                "win": 0,
                "defeat": 1,
                "draw": 0
            }
        },
        {
            "id": 8,
            "total_goals": 0,
            "results": {
                "win": 0,
                "defeat": 0,
                "draw": 0
            }
        },
        {
            "id": 5,
            "total_goals": 0,
            "results": {
                "win": 0,
                "defeat": 0,
                "draw": 0
            }
        },
        {
            "id": 4,
            "total_goals": 0,
            "results": {
                "win": 0,
                "defeat": 0,
                "draw": 0
            }
        },
        {
            "id": 1,
            "total_goals": 0,
            "results": {
                "win": 0,
                "defeat": 0,
                "draw": 0
            }
        }
    ]
}
```

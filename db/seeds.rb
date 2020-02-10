# frozen_string_literal: true

tournament = Tournament.create(name: 'World Cup')

Group.create([{ name: 'A', tournament_id: tournament.id },
              { name: 'B', tournament_id: tournament.id },
              { name: 'C', tournament_id: tournament.id },
              { name: 'D', tournament_id: tournament.id }])

Phase.create([{ name: 'first', tournament_id: tournament.id },
              { name: 'second', tournament_id: tournament.id },
              { name: 'semifinal', tournament_id: tournament.id },
              { name: 'final', tournament_id: tournament.id }])

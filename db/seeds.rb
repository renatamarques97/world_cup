# frozen_string_literal: true

tournament = Tournament.create({ name: 'World Cup' })

Group.create([{ name: 'A', tournament_id: tournament.id },
              { name: 'B', tournament_id: tournament.id },
              { name: 'C', tournament_id: tournament.id },
              { name: 'D', tournament_id: tournament.id }])

Phase.create([{ name: 'All Play All', tournament_id: tournament.id },
              { name: 'Quarter Final', tournament_id: tournament.id },
              { name: 'Semi-Final', tournament_id: tournament.id },
              { name: 'Final', tournament_id: tournament.id }])

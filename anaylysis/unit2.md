| Foreign Key | On DELETE choice | Reason |
|---|---|---|
| player_id | SET NULL | deleting a player should not affect the table and the table is able to exist on its own|
| match_id | CASCADE | deleting the  match_id should delete the recorded match information |
| modes_id | CASCADE | deleting the modes_id should affect the ability to find information about the unique match |

Check constraint on the match type ensures that stored information about the match only provides details of the games being home or away matches. Any other input beside those two would be invalid.

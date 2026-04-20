# Nid_MHS3_Scripts
A collection of mods for Monster Hunter Stories 3.

# Modules - Data
**reframework\autorun\data_modules**

These scripts can get methods and fields from the game to be used in the mod collection.

**..\mhs3_usersave.lua**

Used for getting methods/fields from the user save file.

**..\mhs3_otherdata.lua**

Used for getting methods/fields from the game data.

**..\mhs3_genericfetch.lua**

Used for any methods/fields, requires you to know the path to the field and construct a data table to get there.

# Data Folder
**reframework\data**

Should store some amount of data. I'm not sure what to put here yet.

# Plugins Folder
**reframework\plugins**

I haven't learned any C languages up to this point. This is something to revisit when I do, or when there are more developers working on the repository.

# Planned Mods

**New Game+**

Take 2 monsties from 1 save file and bring them into a new one. This would reset their genes, level and so on. This should also increase difficulty or add more content to the game; this would be a great place to add custom genes.

**Custom Genes**

I am a little dissapointed in the depth of the gene pool and would like to add more.

**Level Caps**

Prevent the player and monstie's from gaining levels for an added layer of difficulty. Planning two features:

- Set level manually
- Automatically adjust level based on enemy

**More Ideas**

Find more mod ideas in the root mod_ideas.md file.
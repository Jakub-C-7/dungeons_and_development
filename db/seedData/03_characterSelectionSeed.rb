CharacterSelection.create(url:"character1.png")
CharacterSelection.create(url:"character2.png")
CharacterSelection.create(url:"character3.png")
CharacterSelection.create(url:"character4.png")


user = User.first;
character_selection = CharacterSelection.first;

user.update(character_selection: character_selection)
p "Finished character selection Seeds"
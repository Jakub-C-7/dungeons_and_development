CharacterSelection.destroy_all

CharacterSelection.create(url:"Character1.svg")
CharacterSelection.create(url:"Character2.svg")
CharacterSelection.create(url:"Character3.svg")
CharacterSelection.create(url:"Character4.svg")


user = User.first;
character_selection = CharacterSelection.first;

user.update(character_selection: character_selection)
p "Finished character selection Seeds"
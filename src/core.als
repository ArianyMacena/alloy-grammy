//GRAMMY AWARDS - Lógica - 2025.1
// Autoras:
// Ariany da Silva Macena
// Ana Paula Soares Cassimiro
// Fabiana Simplício
// Viviane Alves 
// Yasmim Dantas da Costa Souza

//--- CONJUNTO DE ENTIDADES DO DOMÍNIO ---

sig Artist{}

// Representa uma Canção. 
// Toda canção possui pelo menos 1 artista.
sig Song{
    featured: some Artist
}

// Representa um Álbum. 
// Todo álbum possui exatamente um dono (owner) e ao menos uma canção (tracks).
sig Album{
    owner: one Artist,
    tracks: some Song
}

//--- CONJUNTO DE CATEGORIAS DO DOMÍNIO ---

abstract sig Category{
    nominees: set univ
}

one sig BestArtistOrBand extends Category {}
one sig BestAlbum extends Category {}
one sig BestSong extends Category {}
one sig BestCollab extends Category {}

//--- PREDICADOS DE QUANTIDADE ---

// Uma categoria deve ter entre 4 e 8 indicados
pred validCategorySize[c: Category] {
    #c.nominees >= 4 and #c.nominees <= 8
}

// Uma canção pode aparecer em no máximo 2 álbuns
pred songAtMostTwoAlbums[s: Song] {
    #(s.~tracks) <= 2
}

// Pelo menos metade das músicas de Best Song está em álbuns de Best Album
pred atLeastHalfBestSongsInBestAlbums[] {
    let best_songs_in_best_album = (BestSong.nominees & BestAlbum.nominees.tracks), 
        best_songs_not_in_best_album = (BestSong.nominees - BestAlbum.nominees.tracks) |
    #best_songs_in_best_album >= #best_songs_not_in_best_album
}

//--- FATOS (restrições globais) ---

// Apenas 4 categorias principais existem
fact OnlyFourCategories {
    Category = BestArtistOrBand + BestAlbum + BestSong + BestCollab
}

// Cada categoria contém apenas elementos do tipo correto
fact CategoryNominations {
    BestArtistOrBand.nominees in Artist
    BestAlbum.nominees in Album
    BestSong.nominees in Song
    BestCollab.nominees in Song
}

// Toda categoria deve ter entre 4 e 8 indicados
fact CategorySizes {
    all c: Category | validCategorySize[c]
}

// Uma canção pode aparecer em no máximo 2 álbuns
fact SongAtMostTwoAlbums {
    all s: Song | songAtMostTwoAlbums[s]
}

// Todos os indicados a Best Artist são autores de algum álbum indicado a Best Album
fact ArtistNomineesHaveAlbumInBestAlbum {
    all a: BestArtistOrBand.nominees | some al: BestAlbum.nominees | al.owner = a
}

// A quantidade de nomeados a Best Artist é menor ou igual à de nomeados a Best Album
fact ArtistNomineesAreLessOrTheSameNumberOfNominatedAlbums {
    #BestArtistOrBand.nominees <= #BestAlbum.nominees
}

// Todas as canções indicadas como BestCollab possuem mais de um artista
fact CollabOnlyMultipleArtists {
    all s: BestCollab.nominees | #s.featured > 1
}

// Pelo menos metade das canções nomeadas a Best Song está em algum álbum indicado a Best Album
fact BestSongsAreInBestAlbums {
    atLeastHalfBestSongsInBestAlbums[]
}

// ---- ASSERTS ----

assert ArtistsHaveAlbumNomination {
    all a: BestArtistOrBand.nominees | some al: BestAlbum.nominees | al.owner = a
}

assert SongNotInMoreThanTwoAlbums {
    all s: Song | songAtMostTwoAlbums[s]
}

assert OnlyFourCategoriesAssert {
    Category = BestArtistOrBand + BestAlbum + BestSong + BestCollab
}

assert CollabsAreRealCollaborations {
    all s: BestCollab.nominees | #s.featured > 1
}

assert ArtistNomineesAreLessOrTheSameNumberOfAlbums {
    #BestArtistOrBand.nominees <= #BestAlbum.nominees
}

assert AtLeastHalfOfBestSongsAreInSomeAlbumNominatedToBestAlbum {
    atLeastHalfBestSongsInBestAlbums[]
}

//--- RUNS E CHECAGENS DE ASSERTS ---

run {} for 12 but 5 Int

check ArtistsHaveAlbumNomination for 12 but 5 Int
check CollabsAreRealCollaborations for 12 but 5 Int
check ArtistNomineesAreLessOrTheSameNumberOfAlbums for 12 but 5 Int
check AtLeastHalfOfBestSongsAreInSomeAlbumNominatedToBestAlbum for 12 but 5 Int
check SongNotInMoreThanTwoAlbums for 12 but 5 Int
check OnlyFourCategoriesAssert for 12 but 5 Int

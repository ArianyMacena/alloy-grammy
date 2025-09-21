
//GRAMMY AWARDS - Lógica - 2025.1
// Autoras:
// Ariany da Silva Macena
// Ana Paula Soares Cassimiro
// Fabiana Simplício
// Viviane Alves 
// Yasmim Dantas da Costa Souza

//--- CONJUNTO DE ENTIDADES DO DOMÍNIO ---

// A entidade "Artista".
sig Artist{}

//A entidade "Canção", que sempre tem >= 1 artista
sig Song{
    featured: some Artist
}

// A entidade "Álbum", que sempre tem um proprietário e um set de músicas.
sig Album{
    owner: one Artist,
    tracks: some Song
}

//--- CONJUNTO DE CATEGORIAS DO DOMÍNIO ---

//Como é abstrata a categoria, cada uma delas vai herdar, logo: 
abstract sig Category{
    nominees: set univ
}

//Categorias principais
one sig BestArtistOrBand extends Category {}
one sig BestAlbum extends Category {}
one sig BestSong extends Category {}
one sig BestCollab extends Category {}


//--- FATOS E PREDICADOS ---

// Apenas 4 categorias principais existem no Grammy. Isso garante que a assinatura abstrata Category
// é composta exclusivamente por estas quatro subclasses.
fact OnlyFourCategories {
    Category = BestArtistOrBand + BestAlbum + BestSong + BestCollab
}

// A ideia inicial da interpretação do enunciado do problema.
fact CategoryNominations {git 
    BestArtistOrBand.nominees in Artist
    BestAlbum.nominees in Album
    BestSong.nominees in Song
    BestCollab.nominees in Song
}

// Toda categoria deve ter entre 4 e 8 indicados (inclusive).
fact CategorySizes {
    all c: Category | #c.nominees >= 4 && #c.nominees <= 8
}

// Uma canção pode aparecer em no máximo 2 álbuns
fact SongAtMostTwoAlbums {
    all s: Song | #(s.~tracks) <= 2
}

//Todos os nomeados a Best Artist são autores de Best Album.
fact ArtistNomineesHaveAlbumInBestAlbum {
    all a: BestArtistOrBand.nominees | some al: BestAlbum.nominees | al.owner = a
}

//A quantidade de nomeados a Best Artist é menor ou igual à de nomeados a Best Album.
fact ArtistNomineesAreLessOrTheSameNumberOfNominatedAlbums {
    all a: BestArtistOrBand.nominees | #a <= #BestAlbum.nominees
}

//Todas as canções nomeadas a melhor colab possuem mais de um autor.
fact CollabOnlyMultipleArtists {
    all s: BestCollab.nominees | #s.featured > 1
}

//Pelo menos metade das canções nomeadas a Best Song está em algum álbum indicado a Best Album.
fact BestSongsAreInBestAlbums {
    let best_songs_in_best_album = (BestSong.nominees & BestAlbum.nominees.tracks), 
    best_songs_not_in_best_album = (BestSong.nominees - BestAlbum.nominees.tracks)

    {#best_songs_in_best_album >= #best_songs_not_in_best_album}
}

// ---- ASSERTS ----

// Todos os artistas indicados em Best Artist são os autores de pelo menos um álbum indicado como melhor álbum.
assert ArtistsHaveAlbumNomination {
    all a: BestArtistOrBand.nominees | some al: BestAlbum.nominees | al.owner = a
}   

// Todas as canções indicadas como melhor colaboração possuem mais de um artista como seus criadores
assert CollabsAreRealCollaborations {
    all s: BestCollab.nominees | #s.featured > 1
}

// O número de artistas indicados é sempre menor ou igual ao número de álbuns indicados
assert ArtistNomineesAreLessOrTheSameNumberOfAlbums {
    all a: BestArtistOrBand.nominees | #a <= #BestAlbum.nominees
}   

// Pelo menos metade das canções indicadas a Best Song estão em álbuns indicados a Best Album
assert AtLeastHalfOfBestSongsAreInSomeAlbumNominatedToBestAlbum {
    let best_songs_in_best_album = (BestSong.nominees & BestAlbum.nominees.tracks), 
    best_songs_not_in_best_album = (BestSong.nominees - BestAlbum.nominees.tracks)

    {#best_songs_in_best_album >= #best_songs_not_in_best_album}
}  

//--- RUNS E CHECAGENS DE ASSERTS ---

// Roda o programa pra 12 instâncias de cada entidade.
run {} for 12 but 5 Int

// Verifica se todos os indicados a Best Artist são autores de indicados a Best Album.
check ArtistsHaveAlbumNomination for 12 but 5 Int

// Verifica as colaborações.
check CollabsAreRealCollaborations for 12 but 5 Int

// Verifica a questão do número de indicados a Best Artist.
check ArtistNomineesAreLessOrTheSameNumberOfAlbums for 12 but 5 Int

// Verifica a regra de Best Songs.
check AtLeastHalfOfBestSongsAreInSomeAlbumNominatedToBestAlbum for 12 but 5 Int
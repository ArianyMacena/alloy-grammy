

//Meninas, vou deixar alguns comentários aqui para que possa facilitar o entendimento. 
//Fui tentando fazer mais ou menos a ideia que tivemos no último sábado e que Yas anotou.
// Deixei em inglês pq achei mais simples para os nomes das variáveis.

//Tipos do nosso domínio
sig Artist{}

sig Song{
    //lembrar que toda canção, tem >= 1 artista
    featured: some Artist
}

sig Album{
    owner: one Artist,
    tracks: some Song
    // Cada album tem um prorpietário e cada album tem um set de múscias.

}

//Como é abstrata a categoria, cada uma delas vai herdar, logo: 
abstract sig Category{
    // Para incluir nossos nominees aqui, devemos incluir todos? Help
    nominees: some Artist
}

one sig BestArtistOrBand, BestAlbum, BestSong, BestCollab extends Category {}

// A ideia inicial da interpretação do nosso enunciado. 
//Por favor deem uma olhada pois posso ter errado.

fact CategoryNominations {
    BestArtistOrBand.nominees in Artist
    BestAlbum.nominees in Album
    BestSong.nominees in Song
    BestCollab.nominees in Song
}

fact CategorySizes {
    all c: Category | in 4 .. 8
}
module scenarios
open core

/* 
    scenarios.als 
    -seedNameValid(): cenário válido que respeita as regras
    -seedAlmostValid(): cenário que viola a regra da metade das canções
    -seedBoundary4(): testar limite mínimo de 4 indicados
    -seedBoundary8(): testar limite máximo de 8 indicados
    -seedSongInMoreThanTwoAlbuns(): teste de violação da regra "uma música em no máximo 2 álbuns"
*/


// CENÁRIO VÁLIDO
one sig a1, a2, a3, a4 extends Artist{}
one sig al1, al2, al3, al4 extends Album{}
one sig s1, s2, s3, s4, s5, s6, s7, s8, s9 extends Song{}

pred seedNameValid() {
    //ownership (cada álbum tem um proprietário)
    al1.owner = a1
    al2.owner = a2
    al3.owner = a3
    al4.owner = a4

    //tracks (cada álbum tem músicas)
    al1.tracks = s1 + s2
    al2.tracks = s3 + s4
    al3.tracks = s5 + s6
    al4.tracks = s7 + s8 + s9

    //featured
    s1.featured = a1
    s2.featured = a1 + a2   //collab
    s3.featured = a2
    s4.featured = a2 + a3   //collab
    s5.featured = a3
    s6.featured = a3 + a4   //collab
    s7.featured = a4
    s8.featured = a4 + a1   //collab
    s9.featured = a4

    // nominees (4 para cada categoria)
    BestAlbum.nominees = al1 + al2 + al3 + al4
    BestArtistOrBand.nominees = a1 + a2 + a3 + a4
    BestCollab.nominees = s2 + s4 + s6 + s8
    BestSong.nominees = s1 + s2 + s3 + s7
}
--run seedNameValid for 9 Song, 4 Album, 4 Artist


//CENÁRIO QUASE VÁLIDO
pred seedAlmostValid() {
    //pelo menos 4 artistas, álbuns e músicas
    #Artist >= 3
    #Album >= 3
    #Song >= 6

    // exatamente 4 nomeados em cada categoria
    #(BestAlbum.nominees & Album) = 4
    #(BestSong.nominees & Song)  = 4
    #(BestCollab.nominees & Song) >= 4
    #(BestArtistOrBand.nominees & Artist) >= 4

    // força violação: só 1 das canções indicadas em BestSong está em álbuns nomeados
    let S = BestSong.nominees & Song, A = BestAlbum.nominees & Album |
        #(S & A.tracks) = 1

    // colaborações ainda precisam ter mais de 1 artista
    all s: BestCollab.nominees & Song | #s.featured > 1
}
--run seedAlmostValid for 8 Song, 6 Album


//TESTES DE LIMITES
pred seedBoundary4() {
    # (BestAlbum.nominees & Album) = 4
    # (BestSong.nominees  & Song)  = 4
    # (BestCollab.nominees & Song) = 4
    # (BestArtistOrBand.nominees & Artist) = 4

    all s: BestCollab.nominees & Song | #s.featured > 1
}
--run seedBoundary4 for 8 Song, 6 Album

pred seedBoundary8() {
    # (BestAlbum.nominees & Album) = 8
    # (BestSong.nominees  & Song)  = 8
    # (BestCollab.nominees & Song) = 8
    # (BestArtistOrBand.nominees & Artist) = 8

    all s: BestCollab.nominees & Song | #s.featured > 1
}
--run seedBoundary8 for 12 Song, 12 Album


//TESTE DE VIOLAÇÂO: MÚSICA EM MAIS DE 2 ÁLBUNS
one sig t_a1, t_a2, t_a3 extends Artist{}
one sig t_al1, t_al2, t_al3 extends Album{}
one sig t_s1, t_s2, t_s3 extends Song{}

pred seedSongInMoreThanTwoAlbums() {
    // ownership
    t_al1.owner = t_a1
    t_al2.owner = t_a2
    t_al3.owner = t_a3

    // tracks: t_s1 aparece em 3 álbuns (viola regra)
    t_al1.tracks = t_s1 + t_s2
    t_al2.tracks = t_s1 + t_s3
    t_al3.tracks = t_s1

    // featured
    t_s1.featured = t_a1
    t_s2.featured = t_a2
    t_s3.featured = t_a3

    // nominees (preenchimento mínimo)
    BestAlbum.nominees = t_al1 + t_al2 + t_al3
    BestArtistOrBand.nominees = t_a1 + t_a2 + t_a3
    BestCollab.nominees = t_s1 + t_s2
    BestSong.nominees = t_s1 + t_s2 + t_s3
}
--run seedSongInMoreThanTwoAlbums for 3 Album, 3 Song, 3 Artist
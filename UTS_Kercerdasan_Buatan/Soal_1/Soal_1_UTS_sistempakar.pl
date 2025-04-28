% sistem_pakar_hama.pl
% ----------------------------------------
:- use_module(library(readutil)).

gejala(daun_menguning, 'Hama: Kutu Daun').
gejala(bercak_hitam,   'Penyakit: Jamur').
gejala(daun_berlubang, 'Hama: Ulat').
gejala(tanaman_layu,   'Hama: Nematoda').

deteksi_hama(GejalaAtom, Hasil) :-
    (   gejala(GejalaAtom, Hasil)
    ->  true
    ;   Hasil = 'Gejala tidak dikenali'
    ).

main :-
    write('=== Sistem Pakar Deteksi Hama Tanaman ==='), nl,
    write('Daftar Gejala yang tersedia:'), nl,
    write('  1. daun_menguning'), nl,
    write('  2. bercak_hitam'), nl,
    write('  3. daun_berlubang'), nl,
    write('  4. tanaman_layu'), nl, nl,

    write('Masukkan gejala tanaman (pisahkan dengan koma): '), flush_output,
    read_line_to_codes(user_input, Codes),
    string_codes(StrInput, Codes),
    split_string(StrInput, ",", " ", StrList),
    maplist(string_lower, StrList, LowerList),
    maplist(atom_string, AtomList, LowerList),

    nl, write('=== Hasil Deteksi ==='), nl,
    forall(member(G, AtomList), (
        deteksi_hama(G, Hasil),
        format('- ~w : ~w~n', [G, Hasil])
    )).

:- initialization(main).

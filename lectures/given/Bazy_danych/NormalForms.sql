CREATE TABLE MPK (
    NumerLiniITyp TEXT,
    PrzystanekPoczatkowyPetla TEXT,
    PrzystankeKoncowyPetla TEXT,
    OsobyKierujace TEXT,
    MarkaTramwaju TEXT,
    LiczbaPrzystankow INT
);

INSERT INTO MPK (NumerLiniITyp, PrzystanekPoczatkowyPetla, PrzystankeKoncowyPetla, OsobyKierujace, MarkaTramwaju,
                 LiczbaPrzystankow)
VALUES ('1, Zwykla',
        'Salescobar, Ul. Rzemiosla 4, Otwarcie: 12.04.1990, Przepustowosc: 3',
        'Pagorki Krzesimirskie, Ul. Lodowa 60, Otwarcie: 30.06.2004, Przepustowosc: 7',
        'Adam Wielebny (ID: K004), prawo jazdy od 14.02.1999, zarobki: 4350 zl, stanowisko: starszy kierowca',
        'Spitfire 30E, Liczba wejsc: 5, Liczba przegubow: 2, Niskopodlogowy: TAK', 20),
       ('3, Czasowa',
        'Bananow Nowy, Ul. Bitwy Wiedenskiej 24a, Otwarcie: 23.06.1972, Przepustowosc: 7',
        'Krajowa Gorka, Aleje Dwoch Wierszy 36, Otwarcie: 29.04.1991, Przepustowosc: 9',
        'Barbara Soltys (ID: K002), prawo jazdy od 29.02.2008, zarobki: 2500 zl, stanowisko: mlodszy kierowca; Celestyn Krakus (ID: K007), prawo jazdy od 13.11.2013, zarobki: 2200 zl, stanowisko: mlodszy kierowca',
        'Alvaro Bombardierro 06, Liczba wejsc: 3, Liczba przegubow: 1, Niskopodlogowy: NIE', 17
       ),
       ('4, Wspomagajaca',
        'Barszczowice, Ul. Krola Racucha 22, Otwarcie: 10.01.2002, Przepustowosc: 6',
        'Pagorki Krzesimirskie, Ul. Lodowa 60, Otwarcie: 30.06.2004, Przepustowosc: 7',
        'Daniel Tauto (ID: K001), prawo jazdy od 19.01.2003, zarobki: 3000 zl, stanowisko: kierowca',
        'Alvaro Bombardierro 06, Liczba wejsc: 3, Liczba przegubow: 1, Niskopodlogowy: NIE', 14
       ),
       ('5, Przyspieszona',
        'Zielone Tulipany, Ul. Studencka 1, Otwarcie: 26.07.1999, Przepustowosc: 10',
        'Salescobar, Ul. Rzemiosla 4, Otwarcie: 12.04.1990, Przepustowosc: 3',
        'Karol Krawczyk (ID: K009), prawo jazdy od 23.04.1989, zarobki: 5000 zl, stanowisko: starszy kierowca',
        'Buspasse 2k10, Liczba wejsc: 7, Liczba przegubow: 3, Niskopodlogowy: TAK', 13
       ),
       ('7, Zwykla',
        'Osiedle Kombinatorskie, Ul. Na Calce 410, Otwarcie: 14.03.2000, Przepustowosc: 5',
        'lazienniki, Ul. Majora Sekowskiego 82b, Otwarcie: 25.05.1976, Przepustowosc: 5',
        'Michalina Strzelecka (ID: K012), prawo jazdy od 20.06.2006, zarobki: 3900zl, stanowisko: kierowca',
        'Spitfire 30E, Liczba wejsc: 5, Liczba przegubow: 2, Niskopodlogowy: TAK', 29
       ),
       ('60, Nocna',
        'Krajowa Gorka, Aleje Dwoch Wierszy 36, Otwarcie: 29.04.1991, Przepustowosc: 9',
        'Barszczowice, Ul. Krola Racucha 22, Otwarcie: 10.01.2002, Przepustowosc: 6',
        'Hipolit Konstrukt (ID: K011), prawo jazdy od 09.01.1999, zarobki: 3150zl, stanowisko: kierowca; Antonina Napoleon (ID: K006), prawo jazdy od 30.09.2013, zarobki: 4200zl, stanowisko: starszy kierowca',
        'Buspasse 2k10, Liczba wejsc: 7, Liczba przegubow: 3, Niskopodlogowy: TAK', 19
       ),
       ('62, Nocna',
        'lazienniki, Ul. Majora Sekowskiego 82b, Otwarcie: 25.05.1976, Przepustowosc: 5',
        'Bananow Nowy, Ul. Bitwy Wiedenskiej 24a, Otwarcie: 23.06.1972, Przepustowosc: 7',
        'Michal Bachon (ID: K017), prawo jazdy od 10.04.2001, zarobki: 2700 zl, stanowisko: mlodszy kierowca',
        'Buspasse 2k10, Liczba wejsc: 7, Liczba przegubow: 3, Niskopodlogowy: TAK', 23
       ),
       ('74, Wspomagajaca',
        'Barszczowice, Ul. Krola Racucha 22, Otwarcie: 10.01.2002, Przepustowosc: 6',
        'Zielone Tulipany, Ul. Studencka 1, Otwarcie: 26.07.1999, Przepustowosc: 10',
        'Amelia Bialy (ID: K008), prawo jazdy od 23.10.2014, zarobki: 3300 zl, stanowisko: kierowca',
          'Spitfire 30E, Liczba wejsc: 5, Liczba przegubow: 2, Niskopodlogowy: TAK', 31
       );

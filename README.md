# Infosys-SS21

## milestone 1 meeting

- kein Login und Benutzerverwaltung
- ein Benutzer sieht Tabellen
- export to pdf file
- kein email versenden
- möglichst viel in Datenbanklogik

## notices

```sh
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Password1!' --name mssql -p 1433:1433 -d mcr.microsoft.com/mssql/server:2017-latest
docker exec -it mssql /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password1! -Q "$(cat table_script.sql)"
```

dummy daten
```
VALUES ('02.01.2019',  '02.01.2019', 'LASTSCHRIFT',                           'ZWIEBEL ANZ. 4246638                                                        ','                  ZWIEBEL ESSLINGEN                ',          -60,84    )
VALUES ('02.01.2019',  '02.01.2019', 'UEBERWEISUNGSGUTSCHRIFT',               'MIETE MUELLER                                                               ','                  M. MUELLER                       ',          332,34    )
VALUES ('02.01.2019',  '02.01.2019', 'DAUERAUFTRAG',                          'MIETE 300                                                                   ','                  EHELEUTE HAEFELE                 ',          360,00    )
VALUES ('02.01.2019',  '02.01.2019', 'DAUERAUFTRAG',                          'MIETE                                                                       ','                  B. HAUG                          ',          383,47    )
VALUES ('02.01.2019',  '02.01.2019', 'DAUERAUFTRAG',                          'MIETE UND BETRIEBSKOSTEN                                                    ','                  KOSLOWSKI                        ',          488,30    )
VALUES ('03.01.2019',  '03.01.2019', 'LASTSCHRIFT',                           'RG.005633 KD.06399 IHRE KLEINANZEIGE 28.12                                  ','                  WOCHENANZEIGER                   ',          -14,40    )
VALUES ('03.01.2019',  '03.01.2019', 'DAUERAUFTRAG',                          'AUSSTEHENDE MIETE                                                           ','                  B. BARNI                         ',          52,00     )
VALUES ('03.01.2019',  '03.01.2019', 'DAUERAUFTRAG',                          'MIETE MANN                                                                  ','                  MANN                             ',          220,14    )
VALUES ('03.01.2019',  '03.01.2019', 'DAUERAUFTRAG',                          'RIESTER                                                                     ','                  P. RIESTER                       ',          230,00    )
VALUES ('04.01.2019',  '04.01.2019', 'LASTSCHRIFT',                           'LV 566227                                                                   ','                  COSMOSDIREKT VERSICHERUNGEN      ',          -325,49   )
VALUES ('05.01.2019',  '05.01.2019', 'LASTSCHRIFT',                           'ZAHLUNGSBELEG 08692 ZINSEN  1.200 TILGUNG  400 KOST/GEBUEHREN 0,00 013111   ','                  HYPO REAL ESTATE BK MUENCHE      ',          -1.600,00 )
VALUES ('06.01.2019',  '06.01.2019', 'UEBERWEISUNGSGUTSCHRIFT',               ' 347/83456811441/0677440300103                                              ','                  AA ESSLINGEN                     ',          429,49    )
VALUES ('09.01.2019',  '09.01.2019', 'SDIREKT-UEBERWEISUNG',                  ', 18.11 UHR 1.TAN 005949                                                    ','                  ENBW                             ',          -189,66   )
VALUES ('09.01.2019',  '09.01.2019', 'SDIREKT-UEBERWEISUNG',                  ', 18.14 UHR 1.TAN 201739                                                    ','                  STADT ESSLINGEN                  ',          -168,38   )
VALUES ('09.01.2019',  '09.01.2019', 'SDIREKT-UEBERWEISUNG',                  ' 18.08 UHR 1.TAN 986514                                                     ','                  HAUS UND GRUND E.V.              ',          -13,92    )
VALUES ('12.01.2019',  '12.01.2019', 'LASTSCHRIFT',                           'STEUERNR. 776655 STEUER                                                     ','                  FA ESSLINGEN                     ',          -202,08   )
VALUES ('12.01.2019',  '12.01.2019', 'DAUERAUFTRAG',                          'MIETE GRUNER                                                                ','                  STICH                            ',          380,00    )
VALUES ('13.01.2019',  '13.01.2019', 'LASTSCHRIFT',                           '0051175 VERTRAGSKONTO 020054545                                             ','                  ENBW                             ',          -265,00   )
VALUES ('19.01.2019',  '19.01.2019', 'SDIREKT-UEBERWEISUNG',                  'DATUM 19.01.2019, 16.21 UHR 1.TAN 411                                       ','                  HAUG GAS WASSER SCHUTT           ',          -60,00    )
VALUES ('27.01.2019',  '27.01.2019', 'UEBERWEISUNGSGUTSCHRIFT',               'MIETE KOSLOWSKI                                                             ','                  PAUL KOSLOWSKI                   ',          332,34    )
VALUES ('31.01.2019',  '31.01.2019', 'UEBERWEISUNGSGUTSCHRIFT',               '34704BG734553  333 44  434303771 STICH                                      ','                  AA ESSLINGEN                     ',          405,00    )
VALUES ('31.01.2019',  '31.01.2019', 'UEBERWEISUNGSGUTSCHRIFT',               'HAEFELE MIETE                                                               ','                  AA ESSLINGEN                     ',          429,49    )
VALUES ('01.02.2019',  '31.12.2019', 'LASTSCHRIFT',                           'ZAHLUNGSBELEG 08693 ZINSEN  1.200 TILGUNG  400 KOST/GEBUEHREN 0,00 013111   ','                  HYPO REAL ESTATE BK MUENCHEN     ',          -1.600,00 )
```

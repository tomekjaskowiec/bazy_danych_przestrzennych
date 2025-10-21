--a
select id_pracownika, imie from pracownicy1;





--b
select pracownicy1.id_pracownika from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
where pensja.kwota>6000;

--c
select pracownicy1.id_pracownika from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join premia on premia.id_premii=wynagrodzenie.id_premii
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
where wynagrodzenie.id_premii is not null and pensja.kwota>7000.0 ;

--d
select imie from pracownicy1
where nazwisko like 'K%';

--e
select imie from pracownicy1
where nazwisko like '%n%' and imie like '%a';



--f
select pracownicy1.imie, pracownicy1.nazwisko from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join godziny on godziny.id_godziny=wynagrodzenie.id_godziny
where godziny.liczba_godzin-8>0  ;


--g
select pracownicy1.imie, pracownicy1.nazwisko from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
where pensja.kwota>1500 and pensja.kwota<6000  ;


--h
select pracownicy1.imie, pracownicy1.nazwisko from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join godziny on godziny.id_godziny=wynagrodzenie.id_godziny
join premia on premia.id_premii=wynagrodzenie.id_premii
where godziny.liczba_godzin-8>0 and  wynagrodzenie.id_premii is not null;


--i
select pracownicy1.id_pracownika, pracownicy1.imie, pracownicy1.nazwisko, pensja.kwota from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
order by pensja.kwota ;
--j
select pracownicy1.id_pracownika, pracownicy1.imie, pracownicy1.nazwisko, pensja.kwota, premia.kwota from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
join premia on premia.id_premii=wynagrodzenie.id_premii
order by pensja.kwota,premia.kwota DESC;

--k
select count(pracownicy1), pensja.stanowisko from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
group by pensja.stanowisko;

--l
select avg(pensja.kwota), max(pensja.kwota), min(pensja.kwota) from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
where pensja.stanowisko = 'Kierownik'
group by pensja.stanowisko;

--m
select sum(pensja.kwota) from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji;

--n
select sum(pensja.kwota) from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
where pensja.stanowisko = 'Kierownik'
group by pensja.stanowisko;

--o
select count(premia.id_premii), pensja.stanowisko from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
join premia on premia.id_premii=wynagrodzenie.id_premii
group by pensja.stanowisko;

--p
delete from pracownicy1 where id_pracownika in
(
select pracownicy1.id_pracownika from pracownicy1
join wynagrodzenie on pracownicy1.id_pracownika=wynagrodzenie.id_pracownika
join pensja on pensja.id_pensji=wynagrodzenie.id_pensji
where pensja.kwota <120
);
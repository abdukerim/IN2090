--oppgave 1

--oppgave 2
--a)
SELECT  *
FROM    timelistelinje
WHERE   timelistenr = 3;
--9 rad

--b)
SELECT  count(*)
FROM    timeliste;

--8 timelister

--c)
SELECT  count(*)
FROM    timeliste
WHERE   utbetalt IS NULL;

-- 3 timelister som ikke utbetalt penger for

--d)

SELECT  (SELECT COUNT(linjenr)
        FROM    timelistelinje) AS antall_linjer,
        (SELECT COUNT(pause)
        FROM    timelistelinje
        WHERE   pause IS NOT NULL) AS pause_verdi;

-- 34 antall_linjer, og 12 med pause verdi

--e)
SELECT  *
FROM    timelistelinje
WHERE   pause IS NULL;

-- 22 rader


--oppgave 3
--a)
SELECT  sum(ROUND((v.varighet / 60.0),2)) AS antall_timer
FROM    varighet AS v INNER JOIN
        timeliste AS t
        ON (v.timelistenr = t.timelistenr)
WHERE   t.utbetalt IS NULL;

-- 10 timer

--b)
SELECT  DISTINCT t.timelistenr,t.beskrivelse
FROM    timeliste AS t
        INNER JOIN timelistelinje AS tl ON
        (t.timelistenr = tl.timelistenr)
WHERE   tl.beskrivelse LIKE '%test%' OR tl.beskrivelse LIKE '%Test%';

--her antar jeg at vi ikke har mellom rom etter 'Test' eller 'test'
--alternativ  LIKE '%est%', men den kunne slår ut feil i tilfelle vi har ord som 'best', 'rest' ....

--c)
SELECT  sum(ROUND((v.varighet / 60.0)*200,1)) AS antall_timer
FROM    varighet AS v INNER JOIN
        timeliste AS t
        ON (v.timelistenr = t.timelistenr)
WHERE   t.utbetalt IS NOT NULL;

--brukt round til å få rundet tall
-- det er tilsammen 13266 kr utbetalt

--oppgave 4
--a)
SELECT  count(*)
FROM    timeliste NATURAL JOIN timelistelinje;

--her sql joiner to tabeller basert på samme kolonne navn, der timelistenr og beskrivelse er felles på begge to tabellene,
--og finner tilslutt bare en rad som har linjenr 2 og beskrivelse "inføring", vi får ikke noe duplikate kolonner.

SELECT  count(*)
FROM    timeliste AS t
        INNER JOIN timelistelinje AS l
        ON (t.timelistenr = l.timelistenr);
--med inner join vi gir condition explicit at attributten timelistenr skal være lik, da spørringen tar ikke hensyn på beskrivelse kolonne,
--dermed vi henter alle dataene fra begge tabellene basert på timelistenr. Og vi får duplikate kolonner.
--resultat 34 rad

--b)
SELECT  count(*)
FROM    timeliste
        NATURAL JOIN varighet;




SELECT  count(*)
FROM    timeliste AS t
        INNER JOIN varighet AS v
        ON (t.timelistenr = v.timelistenr);
--selve view  varighet har vi hentet fra timelistelinje, view er egenlig spørringer som vi har lagret i databasen,
--vi kunne få varighet sql spørring som:

--SELECT l.timelistenr,t.linjenr, diff(l.startdato,l.sluttid - l.starttid) AS varighet
--FROM    timelistelinje AS l;

--etter spørringen har vi ikke tatt med beskrivelse attributten, dermed hvis vi natural joine med timeliste, spørringen automatisk
--finner fram kolonne med samme navn, som er 'timelistenr', med inner join med condition (t.timelistenr = v.timelistenr), gjør vi det
--akkurat det samme. derfor får vi samme resulatt.
--34 rader

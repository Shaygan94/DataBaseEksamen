-- oppgave a--
select * from kunstverk
where år > 2000;

-- oppgave b -- 
select * from kunstverk
order by pris desc
limit 3;

-- oppgave c --
Select sum(pris) as TotalVerdi
from kunstverk;

-- oppgave d -- 
Select kv.tittel, ku.navn
from kunstverk as kv
join kunstnere as ku
on kv.KunstnerID = ku.KunstnerID;

-- oppgave e -- 
Select ku.navn, count(salgID) as AntallSolgte
from kunstnere as ku
join kunstverk as kv
on ku.KunstnerID = kv.KunstnerID
join salg as s
on kv.KunstverkID = s.KunstverkID
Group by ku.navn
Having count(SalgID) > 1;

-- oppgave f --
select avg(pris)
from kunstverk;
Select * from kunstverk 
where pris > (Select avg(pris) from kunstverk)
order by pris desc;

-- oppgave g -- 
CREATE OR REPLACE VIEW kunst_view AS
select ut.navn as UtstillingsNavn, ut.Startdato, ut.Sluttdato, kv.tittel, ku.navn as KunsterNavn, kv.Pris
from utstillinger as ut
join utstillingsdeltakelse as ud
on ut.UtstillingID = ud.UtstillingID
join kunstverk as kv
on ud.KunstverkID = kv.KunstverkID
join kunstnere as ku 
on kv.KunstnerID = ku.KunstnerID
order by ut.Startdato, kv.pris desc;
select * from kunst_view;

-- oppgave h -- Må slette alle FK til kunstverkID where år < 2000 først i andre tabeller
Delete from utstillingsdeltakelse
where KunstverkID in (
SELECT KunstverkID
FROM kunstverk
WHERE år < 2000
);
Delete from Salg
WHERE kunstverkID in (
SELECT kunstverkID
from kunstverk
where år < 2000
);
Delete from Kunstverk
where år < 2000;
Select * from Kunstverk
order by år asc;

-- oppgave i -- Må joine tabellene kunstverk og utstillinger først
Select * from kunstverk;
select * from utstillinger;
Update kunstverk as kv
Join utstillingsdeltakelse as ud
on kv.kunstverkID = ud.kunstverkID
join utstillinger AS ut
on ud.utstillingID = ut.utstillingID
Set kv.pris = 70000
WHERE kv.type = 'videoinstallasjon'
AND ut.navn = 'videokunstens fremtid';
Select kv.type, ut.navn, kv.pris
from kunstverk as kv
join utstillingsdeltakelse as ud
on kv.KunstverkID = ud.kunstverkID
join utstillinger as ut
on ud.utstillingID = ut.utstillingID
where kv.type = 'videoinstallasjon'
and ut.navn = 'videokunstens fremtid';

-- oppgave j --
Alter table Kunstverk
Add Medium ENUM('olje','akryl','digital');
Select * from kunstverk;





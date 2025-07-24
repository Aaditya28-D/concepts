SELECT astroname
FROM nasa2_astronaut
WHERE astrono IN (
    SELECT astrono
    FROM nasa2_mission
    WHERE projectname ='Apollo'
    AND missiontype ='LL'
);



SELECT astroname
FROM nasa2_astronaut
WHERE astrono IN (
    SELECT nasa2_assigned.astrono
    FROM nasa2_assigned
    INNER JOIN nasa2_mission ON nasa2_assigned.projectname =nasa2_mission.projectname 
                             AND nasa2_assigned.missionno=nasa2_mission.missionno
    WHERE nasa2_mission.launchyear = '1961'
);



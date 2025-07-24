
-- NASA2 fixed script

DROP TABLE IF EXISTS space;

CREATE TABLE space (
    id SERIAL PRIMARY KEY,
    name TEXT,
    country TEXT,
    mass INTEGER
);

INSERT INTO space (name, country, mass) VALUES ('Voyager 1', 'USA', 721);
INSERT INTO space (name, country, mass) VALUES ('Sputnik', 'USSR', 84);
INSERT INTO space (name, country, mass) VALUES ('Hubble Telescope', 'USA', 11110);

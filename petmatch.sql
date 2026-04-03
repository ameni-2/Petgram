
-- PetMatch - Base de données
CREATE DATABASE IF NOT EXISTS petmatch_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE petmatch_db;

-- ============================================
-- TABLE : user
-- username, password (hashé), role (admin/user)
-- ============================================
CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB;

-- ============================================
-- TABLE : race (équivalent "section" de l'atelier)
-- designation = type d'animal, description = détails
-- ============================================
CREATE TABLE IF NOT EXISTS race (
    id INT AUTO_INCREMENT PRIMARY KEY,
    designation VARCHAR(100) NOT NULL,
    description TEXT
) ENGINE=InnoDB;

-- ============================================
-- TABLE : animal (équivalent "etudiant" de l'atelier)
-- nom, image, date_naissance, race_id
-- ============================================
CREATE TABLE IF NOT EXISTS animal (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    image VARCHAR(255) DEFAULT 'default.png',
    date_naissance DATE NOT NULL,
    race_id INT NOT NULL,
    FOREIGN KEY (race_id) REFERENCES race(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================
-- DONNÉES DE TEST
-- ============================================

-- Utilisateurs (passwords hashés avec password_hash PHP)
-- admin123 => hash bcrypt
-- user123  => hash bcrypt
INSERT INTO user (username, password, role) VALUES
('admin@petmatch.tn',   '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('sara@petmatch.tn',    '$2y$10$TKh8H1.PFbuSpgzjz0uPquYSK7BmLPdlxOH7JGFZAVYHRpG5Xg2Y2', 'user'),
('karim@petmatch.tn',   '$2y$10$TKh8H1.PFbuSpgzjz0uPquYSK7BmLPdlxOH7JGFZAVYHRpG5Xg2Y2', 'user');
-- Mot de passe admin : password
-- Mot de passe sara et karim : password

-- Races / Types d'animaux
INSERT INTO race (designation, description) VALUES
('Chien',   'Meilleur ami de l\'homme, fidèle et affectueux. Idéal pour les familles actives.'),
('Chat',    'Animal indépendant et doux. Parfait pour les appartements et les personnes calmes.'),
('Lapin',   'Animal paisible et mignon. Convient aux enfants et aux petits espaces.'),
('Perroquet','Oiseau intelligent et bavard. Aime l\'interaction et la stimulation mentale.');

-- Animaux à adopter
INSERT INTO animal (nom, image, date_naissance, race_id) VALUES
('Luna',    'default.png', '2021-03-15', 1),
('Milo',    'default.png', '2020-07-22', 2),
('Caramel', 'default.png', '2022-01-10', 1),
('Noisette','default.png', '2019-11-05', 3),
('Coco',    'default.png', '2018-06-30', 4),
('Zara',    'default.png', '2023-02-14', 2),
('Rex',     'default.png', '2020-09-18', 1);

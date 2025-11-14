-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : ven. 14 nov. 2025 à 20:55
-- Version du serveur : 8.0.43-0ubuntu0.24.04.2
-- Version de PHP : 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `RandoLib`
--

-- --------------------------------------------------------

--
-- Structure de la table `Equipement`
--

CREATE TABLE `Equipement` (
  `id_equipement` int NOT NULL,
  `nom` varchar(20) NOT NULL,
  `description` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Participation`
--

CREATE TABLE `Participation` (
  `id_randonnee` int NOT NULL,
  `id_randonneur` int NOT NULL,
  `date_participation` date NOT NULL,
  `duree` time NOT NULL,
  `commentaire` varchar(20) DEFAULT NULL,
  `note` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Passage`
--

CREATE TABLE `Passage` (
  `id_randonnee` int NOT NULL,
  `id_point` int NOT NULL,
  `ordre_passage` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Point_interet`
--

CREATE TABLE `Point_interet` (
  `id_point` int NOT NULL,
  `nom` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Randonnee`
--

CREATE TABLE `Randonnee` (
  `id_randonee` int NOT NULL,
  `nom` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  `distance` float NOT NULL,
  `denivele` float NOT NULL,
  `duree_estime` datetime NOT NULL,
  `lieu_depart` varchar(20) NOT NULL,
  `lieu_arrive` varchar(20) NOT NULL,
  `niveau` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL
) ;

-- --------------------------------------------------------

--
-- Structure de la table `Randonneur`
--

CREATE TABLE `Randonneur` (
  `id_randonneur` int NOT NULL,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `date_naissance` date NOT NULL,
  `profession` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Recommandation`
--

CREATE TABLE `Recommandation` (
  `id_randonnee` int NOT NULL,
  `id_equipement` int NOT NULL,
  `obligatoire` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Equipement`
--
ALTER TABLE `Equipement`
  ADD PRIMARY KEY (`id_equipement`);

--
-- Index pour la table `Participation`
--
ALTER TABLE `Participation`
  ADD PRIMARY KEY (`id_randonnee`,`id_randonneur`),
  ADD UNIQUE KEY `id_randonnee` (`id_randonnee`),
  ADD KEY `fk_partirandonneur` (`id_randonneur`);

--
-- Index pour la table `Passage`
--
ALTER TABLE `Passage`
  ADD PRIMARY KEY (`id_randonnee`,`id_point`),
  ADD UNIQUE KEY `id_randonnee` (`id_randonnee`),
  ADD KEY `fk_passagepoint` (`id_point`);

--
-- Index pour la table `Point_interet`
--
ALTER TABLE `Point_interet`
  ADD PRIMARY KEY (`id_point`);

--
-- Index pour la table `Randonnee`
--
ALTER TABLE `Randonnee`
  ADD PRIMARY KEY (`id_randonee`);

--
-- Index pour la table `Randonneur`
--
ALTER TABLE `Randonneur`
  ADD PRIMARY KEY (`id_randonneur`);

--
-- Index pour la table `Recommandation`
--
ALTER TABLE `Recommandation`
  ADD PRIMARY KEY (`id_randonnee`,`id_equipement`),
  ADD UNIQUE KEY `id_randonnee` (`id_randonnee`),
  ADD KEY `fk_recoequipement` (`id_equipement`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Equipement`
--
ALTER TABLE `Equipement`
  MODIFY `id_equipement` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Point_interet`
--
ALTER TABLE `Point_interet`
  MODIFY `id_point` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Randonnee`
--
ALTER TABLE `Randonnee`
  MODIFY `id_randonee` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Randonneur`
--
ALTER TABLE `Randonneur`
  MODIFY `id_randonneur` int NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Participation`
--
ALTER TABLE `Participation`
  ADD CONSTRAINT `fk_partirandonnee` FOREIGN KEY (`id_randonnee`) REFERENCES `Randonnee` (`id_randonee`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_partirandonneur` FOREIGN KEY (`id_randonneur`) REFERENCES `Randonneur` (`id_randonneur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Passage`
--
ALTER TABLE `Passage`
  ADD CONSTRAINT `fk_passagepoint` FOREIGN KEY (`id_point`) REFERENCES `Point_interet` (`id_point`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_passagerandonnee` FOREIGN KEY (`id_randonnee`) REFERENCES `Randonnee` (`id_randonee`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Recommandation`
--
ALTER TABLE `Recommandation`
  ADD CONSTRAINT `fk_recoequipement` FOREIGN KEY (`id_equipement`) REFERENCES `Equipement` (`id_equipement`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_recorandonnee` FOREIGN KEY (`id_randonnee`) REFERENCES `Randonnee` (`id_randonee`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Thu Jan  7 19:56:08 2016
-- 
;
SET foreign_key_checks=0;
--
-- Table: `auth`
--
CREATE TABLE `auth` (
  `id` bigint unsigned NOT NULL auto_increment,
  `auth_key` varchar(255) NOT NULL,
  `login` timestamp NOT NULL DEFAULT current_timestamp,
  `device` bigint unsigned NOT NULL,
  `logout` datetime NULL,
  INDEX `auth_idx_device` (`device`),
  PRIMARY KEY (`id`, `auth_key`),
  UNIQUE `id` (`id`),
  CONSTRAINT `auth_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
--
-- Table: `clicks`
--
CREATE TABLE `clicks` (
  `id` bigint unsigned NOT NULL auto_increment,
  `value` decimal(2, 0) NULL,
  `photolink` bigint unsigned NOT NULL,
  `device` bigint unsigned NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp,
  `user` bigint unsigned NULL,
  INDEX `clicks_idx_device` (`device`),
  INDEX `clicks_idx_photolink` (`photolink`),
  INDEX `clicks_idx_user` (`user`),
  PRIMARY KEY (`id`),
  CONSTRAINT `clicks_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `clicks_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `clicks_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
--
-- Table: `code_data`
--
CREATE TABLE `code_data` (
  `idcode_data` integer NOT NULL,
  `datatype` varchar(45) NOT NULL,
  `dataid` integer NOT NULL,
  `components_idcomponents` integer NOT NULL,
  INDEX `code_data_idx_components_idcomponents` (`components_idcomponents`),
  PRIMARY KEY (`idcode_data`, `components_idcomponents`),
  CONSTRAINT `code_data_fk_components_idcomponents` FOREIGN KEY (`components_idcomponents`) REFERENCES `components` (`idcomponents`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;
--
-- Table: `components`
--
CREATE TABLE `components` (
  `idcomponents` integer NOT NULL,
  `name` varchar(45) NULL,
  `href` varchar(255) NULL,
  `doc` longtext NULL,
  PRIMARY KEY (`idcomponents`)
) ENGINE=InnoDB;
--
-- Table: `device_models`
--
CREATE TABLE `device_models` (
  `id` bigint unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE `name` (`name`)
) ENGINE=InnoDB;
--
-- Table: `device_photolinks`
--
CREATE TABLE `device_photolinks` (
  `photolink` bigint unsigned NOT NULL DEFAULT 0,
  `device` bigint unsigned NOT NULL DEFAULT 0,
  `sent` timestamp NOT NULL DEFAULT current_timestamp,
  INDEX `device_photolinks_idx_device` (`device`),
  INDEX `device_photolinks_idx_photolink` (`photolink`),
  PRIMARY KEY (`photolink`, `device`),
  CONSTRAINT `device_photolinks_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `device_photolinks_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
--
-- Table: `devices`
--
CREATE TABLE `devices` (
  `id` bigint unsigned NOT NULL auto_increment,
  `os` varchar(45) NULL,
  `number` varchar(45) NULL,
  `cache` blob NULL,
  `model` bigint unsigned NOT NULL,
  `user` bigint unsigned NOT NULL,
  INDEX `devices_idx_model` (`model`),
  INDEX `devices_idx_user` (`user`),
  PRIMARY KEY (`id`),
  CONSTRAINT `devices_fk_model` FOREIGN KEY (`model`) REFERENCES `device_models` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `devices_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
--
-- Table: `mojo_migrations`
--
CREATE TABLE `mojo_migrations` (
  `name` varchar(255) NOT NULL,
  `version` bigint NOT NULL,
  UNIQUE `name` (`name`)
);
--
-- Table: `mojo_pubsub_notify`
--
CREATE TABLE `mojo_pubsub_notify` (
  `id` integer NOT NULL auto_increment,
  `channel` varchar(64) NOT NULL,
  `payload` text NULL,
  `ts` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`)
);
--
-- Table: `mojo_pubsub_subscribe`
--
CREATE TABLE `mojo_pubsub_subscribe` (
  `id` integer NOT NULL auto_increment,
  `pid` integer NOT NULL,
  `channel` varchar(64) NOT NULL,
  `ts` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`),
  UNIQUE `subs_idx` (`pid`, `channel`)
);
--
-- Table: `movies`
--
CREATE TABLE `movies` (
  `id` bigint unsigned NOT NULL auto_increment,
  `title` varchar(45) NULL,
  `description` varchar(255) NULL,
  `url` text NULL,
  `player` varchar(45) NULL,
  `image` text NULL,
  PRIMARY KEY (`id`),
  UNIQUE `title` (`title`)
) ENGINE=InnoDB;
--
-- Table: `photolinks`
--
CREATE TABLE `photolinks` (
  `id` bigint unsigned NOT NULL auto_increment,
  `title` varchar(45) NULL,
  `description` varchar(255) NULL,
  `mediatype` varchar(45) NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
--
-- Table: `points`
--
CREATE TABLE `points` (
  `id` bigint unsigned NOT NULL auto_increment,
  `x` integer NULL,
  `y` integer NULL,
  `t` double precision NOT NULL,
  `trackmotion` bigint unsigned NOT NULL,
  INDEX `points_idx_trackmotion` (`trackmotion`),
  PRIMARY KEY (`id`),
  CONSTRAINT `points_fk_trackmotion` FOREIGN KEY (`trackmotion`) REFERENCES `trackmotions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
--
-- Table: `providers`
--
CREATE TABLE `providers` (
  `idproviders` integer NOT NULL,
  `level` integer NULL,
  `avatar` varchar(255) NULL,
  PRIMARY KEY (`idproviders`)
);
--
-- Table: `redirects`
--
CREATE TABLE `redirects` (
  `id` bigint unsigned NOT NULL auto_increment,
  `user` bigint unsigned NOT NULL,
  `movie` bigint unsigned NOT NULL,
  `photolink` bigint unsigned NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp,
  `redirect_to` text NOT NULL,
  `price` integer NOT NULL DEFAULT 0,
  `divisor_for_cents` integer NOT NULL DEFAULT 100,
  INDEX `redirects_idx_movie` (`movie`),
  INDEX `redirects_idx_photolink` (`photolink`),
  INDEX `redirects_idx_user` (`user`),
  PRIMARY KEY (`id`),
  CONSTRAINT `redirects_fk_movie` FOREIGN KEY (`movie`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `redirects_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `redirects_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
--
-- Table: `thumbs`
--
CREATE TABLE `thumbs` (
  `idthumbs` integer NOT NULL auto_increment,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`idthumbs`)
);
--
-- Table: `trackmotions`
--
CREATE TABLE `trackmotions` (
  `photolink` bigint unsigned NOT NULL,
  `id` bigint unsigned NOT NULL auto_increment,
  `thumb` varchar(255) NULL,
  `movie` bigint unsigned NOT NULL,
  INDEX `trackmotions_idx_movie` (`movie`),
  INDEX `trackmotions_idx_photolink` (`photolink`),
  PRIMARY KEY (`id`),
  CONSTRAINT `trackmotions_fk_movie` FOREIGN KEY (`movie`) REFERENCES `movies` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `trackmotions_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
--
-- Table: `urls`
--
CREATE TABLE `urls` (
  `id` bigint unsigned NOT NULL auto_increment,
  `href` varchar(255) NULL,
  `value` decimal(2, 0) NULL,
  `description` varchar(255) NULL,
  `photolink` bigint unsigned NOT NULL,
  `title` varchar(45) NULL,
  INDEX `urls_idx_photolink` (`photolink`),
  UNIQUE `id` (`id`),
  CONSTRAINT `urls_fk_photolink` FOREIGN KEY (`photolink`) REFERENCES `photolinks` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
--
-- Table: `users`
--
CREATE TABLE `users` (
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `create_time` timestamp NULL DEFAULT current_timestamp,
  `id` bigint unsigned NOT NULL auto_increment,
  `salt` char(15) NOT NULL,
  `counter` integer NULL DEFAULT 1024,
  `active` tinyint NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE `username` (`username`)
) ENGINE=InnoDB;
--
-- Table: `users_has_devices`
--
CREATE TABLE `users_has_devices` (
  `user` bigint unsigned NOT NULL DEFAULT 0,
  `device` bigint unsigned NOT NULL DEFAULT 0,
  INDEX `users_has_devices_idx_device` (`device`),
  INDEX `users_has_devices_idx_user` (`user`),
  PRIMARY KEY (`user`, `device`),
  CONSTRAINT `users_has_devices_fk_device` FOREIGN KEY (`device`) REFERENCES `devices` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `users_has_devices_fk_user` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB;
--
-- Table: `watchers`
--
CREATE TABLE `watchers` (
  `idwatchers` integer NOT NULL,
  `level` integer NULL,
  `avatar` varchar(255) NULL,
  PRIMARY KEY (`idwatchers`)
);
SET foreign_key_checks=1;

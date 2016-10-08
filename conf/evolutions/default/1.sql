# --- Created by Ebean DDL
# To stop Ebean DDL generation, remove this comment and start using Evolutions

# --- !Ups

create table amount (
  id                            bigint not null,
  amount                        integer not null,
  unit                          integer not null,
  constraint ck_amount_unit check (unit in (0,1,2)),
  constraint pk_amount primary key (id)
);
create sequence amount_seq;

create table ingredient (
  id                            bigint not null,
  recipe_id                     bigint not null,
  produce_id                    bigint,
  amount_id                     bigint,
  constraint pk_ingredient primary key (id)
);
create sequence ingredient_seq;

create table produce (
  id                            bigint not null,
  name                          varchar(255),
  constraint pk_produce primary key (id)
);
create sequence produce_seq;

create table recipe (
  id                            bigint not null,
  name                          varchar(64) not null,
  instructions                  varchar(255),
  picture_url                   varchar(255) not null,
  creation_date                 timestamp,
  preparation_time_in_minutes   integer,
  skill_required                integer,
  owner_id                      bigint,
  constraint pk_recipe primary key (id)
);
create sequence recipe_seq;

create table recipe_category (
  id                            bigint not null,
  name                          varchar(255),
  constraint pk_recipe_category primary key (id)
);
create sequence recipe_category_seq;

create table socobo_user (
  id                            bigint not null,
  user_name                     varchar(256) not null,
  constraint uq_socobo_user_user_name unique (user_name),
  constraint pk_socobo_user primary key (id)
);
create sequence socobo_user_seq;

alter table ingredient add constraint fk_ingredient_recipe_id foreign key (recipe_id) references recipe (id) on delete restrict on update restrict;
create index ix_ingredient_recipe_id on ingredient (recipe_id);

alter table ingredient add constraint fk_ingredient_produce_id foreign key (produce_id) references produce (id) on delete restrict on update restrict;
create index ix_ingredient_produce_id on ingredient (produce_id);

alter table ingredient add constraint fk_ingredient_amount_id foreign key (amount_id) references amount (id) on delete restrict on update restrict;
create index ix_ingredient_amount_id on ingredient (amount_id);

alter table recipe add constraint fk_recipe_owner_id foreign key (owner_id) references socobo_user (id) on delete restrict on update restrict;
create index ix_recipe_owner_id on recipe (owner_id);


# --- !Downs

alter table ingredient drop constraint if exists fk_ingredient_recipe_id;
drop index if exists ix_ingredient_recipe_id;

alter table ingredient drop constraint if exists fk_ingredient_produce_id;
drop index if exists ix_ingredient_produce_id;

alter table ingredient drop constraint if exists fk_ingredient_amount_id;
drop index if exists ix_ingredient_amount_id;

alter table recipe drop constraint if exists fk_recipe_owner_id;
drop index if exists ix_recipe_owner_id;

drop table if exists amount;
drop sequence if exists amount_seq;

drop table if exists ingredient;
drop sequence if exists ingredient_seq;

drop table if exists produce;
drop sequence if exists produce_seq;

drop table if exists recipe;
drop sequence if exists recipe_seq;

drop table if exists recipe_category;
drop sequence if exists recipe_category_seq;

drop table if exists socobo_user;
drop sequence if exists socobo_user_seq;


create table department (
    dept_id int primary key,
    dname varchar(100) not null,
    location varchar(100),
    manager_ssn int unique
);


create table employee (
    ssn int primary key,
    fname varchar(50) not null,
    lname varchar(50) not null,
    gender char(1) check (gender in ('m', 'f')),
    birth_date date not null,
    dept_id int not null,
    email varchar(100),
    supervisor_ssn int,
    foreign key (dept_id) references department(dept_id) on delete set null on update cascade
);


alter table department add constraint fk_manager_ssn foreign key (manager_ssn) references employee(ssn) on delete set null on update cascade;

alter table employee add constraint fk_supervisor foreign key (supervisor_ssn) references employee(ssn);

create table project (
    project_id int primary key,
    pname varchar(100) not null,
    location varchar(150),
    dept_id int not null,
    foreign key (dept_id) references department(dept_id) on delete cascade on update cascade
);

create table works_on (
    emp_ssn int,
    project_id int,
    hours decimal(5,2) default 0,
    primary key (emp_ssn, project_id),
    foreign key (emp_ssn) references employee(ssn) on delete cascade on update cascade,
    foreign key (project_id) references project(project_id) on delete cascade on update cascade
);

create table dependent (
    dep_id int primary key,
    dep_name varchar(50) not null,
    gender char(1) check (gender in ('m', 'f')),
    birth_date date not null,
    emp_ssn int not null,
    foreign key (emp_ssn) references employee(ssn) on delete cascade on update cascade
);

alter table project alter column location varchar(150);

alter table department drop constraint fk_manager_ssn;

insert into department values (1, 'hr', 'cairo', null);
insert into department values (2, 'it', 'alex', null);

insert into employee values (101, 'ali', 'hassan', 'm', '1985-01-01', 1, null, null);
insert into employee values (102, 'mona', 'adel', 'f', '1990-03-05', 1, null, null);

update department set manager_ssn = 101 where dept_id = 1;

insert into project values (1, 'erp', 'cairo', 1);

insert into works_on values (101, 1, 20.5);

insert into dependent values (1, 'omar jr', 'm', '2012-06-01', 101);

select * from production.products where list_price > 1000;

select * from sales.customers where state in ('ca', 'ny');

select * from sales.orders where year(order_date) = 2023;

select * from sales.customers where email like '%@gmail.com';

select * from sales.staffs where active = 0;

select top 5 * from production.products order by list_price desc;

select top 10 * from sales.orders order by order_date desc;

select top 3 * from sales.customers order by last_name asc;

select * from sales.customers where phone is null;

select * from sales.staffs where manager_id is not null;

select category_id, count(*) as product_count
from production.products
group by category_id;

select state, count(*) as customer_count
from sales.customers
group by state;

select brand_id, avg(list_price) as avg_price
from production.products
group by brand_id;

select staff_id, count(*) as total_orders
from sales.orders
group by staff_id;

select customer_id
from sales.orders
group by customer_id
having count(*) > 2;

select * from production.products
where list_price between 500 and 1500;

select * from sales.customers
where city like 's%';

select * from sales.orders
where order_status in (2, 4);

select * from production.products
where category_id in (1, 2, 3);

select * from sales.staffs
where store_id = 1 or phone is null;

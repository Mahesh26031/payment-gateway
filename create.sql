CREATE  TABLE Customers
(
    id bigserial PRIMARY KEY unique,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phoneno int NOT NULL,
    address varchar(255) not null,
)


CREATE  TABLE currency
(
  id bigserial primary key unique,
  country VARCHAR(255) NOT NULL,
  currency TEXT NOT NULL
)

CREATE  TABLE mode
(
  id bigserial primary key unique,
  payment_mode VARCHAR(255) NOT NULL
 
)

create table transactions(
  id bigserial primary key unique,
  customer_id  bigint not null references customers(id),
  currency_id bigint not null references currency(id),
  payment_mode_id bigint not null references mode(id),
  amount decimal not null,
  status VARCHAR(255) NOT NULL,
  created_at TIMESTAMP
  
);

create table payments(
  id bigserial primary key unique,
  customer_id  bigint not null references customers(id),
  amount decimal not null,
  refund_status BOOLEAN NOT NULL,
  refunded decimal not null,
  captured BOOLEAN NOT NULL
);

CREATE  TABLE chargebacks
(
      id bigserial PRIMARY KEY unique,
      customer_id  bigint not null references customers(id),
      chargebacks bigint,
      success BIGINT,
      unsuccess bigint     
      
)

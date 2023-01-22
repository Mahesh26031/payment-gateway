CREATE  TABLE Customers
(
    id bigserial PRIMARY KEY unique,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    phoneno VARCHAR(255) NOT NULL,
    address varchar(255) not null
)

CREATE  TABLE currencies
(
  id bigserial primary key unique,
  country VARCHAR(255) NOT NULL,
  currency TEXT NOT NULL
)

CREATE  TABLE payment_modes
(
  id bigserial primary key unique,
  mode_of_payment VARCHAR(255) NOT NULL,
  type_of_mode VARCHAR(255) NOT NULL
)

create table payments(
  id bigserial primary key unique,
  customer_id  bigint not null references customers(id),
  amount decimal not null
);

create table transactions(
  id bigserial primary key unique,
  currency_id bigint not null references currencies(id),
  payment_mode_id bigint not null references payment_modes(id),
  status varchar(255) NOT NULL,
  ref_id text NOT NULL,
  description TEXT ,
  created_at TIMESTAMP NOT NULL,
  account text ,
  cardnumber text ,
  osdata varchar(255) not null
    
);

CREATE  TABLE chargebacks
(
      id bigserial PRIMARY KEY unique,
      transaction_id  bigint not null references transactions(id),
      chargeback_status decimal,
      chargeback_amount decimal
)

Alter table transactions
add payment_id  bigint not null references payments(id)

CREATE  TABLE refunds
(
      id bigserial PRIMARY KEY unique,
      transaction_id  bigint not null references transactions(id),
      refund_status varchar,
      refund_amount decimal
)

CREATE INDEX idx_amount
ON payments(amount);

CREATE INDEX idx_refund_amount
ON refunds(refund_amount);

CREATE INDEX idx_payment_mode
ON payment_modes(mode_of_payment,type_of_mode);

CREATE INDEX idx_name
ON customers(name);

CREATE INDEX idx_currency
ON currencies(currency);
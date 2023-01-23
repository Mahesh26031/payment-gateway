-- 1.1 no.of payments failed and succesful
    SELECT count(*) FROM transactions 
    WHERE status='success';

    SELECT count(*) FROM transactions 
    WHERE status='failed';

-- 1.2 total amount captured 
    SELECT sum(b.amount) from payments as b 
    join transactions as a on b.id=a.payment_id 
    where a.status='success';

-- 1.3 total amount refunded
     SELECT sum(refund_amount) from refunds 
     where refund_status='success';

-- 2. List of payment mode with highest success rate
  SELECT b.mode_of_payment,b.type_of_mode,count(*) from transactions as a 
  join payment_modes as b on b.id=a.payment_mode_id
  WHERE a.status='success'
  group by a.payment_mode_id,b.mode_of_payment,b.type_of_mode 
  ORDER by count(*) desc
    

-- 3. Search for payment with customer email or payment id in one query. Add optional filters like date/date range, amount, currency
   SELECT a.name,b.amount FROM customers as a JOIN payments as b on a.id=b.customer_id
   where a.email='ram@gmail.com';
 
   SELECT a.name,b.amount FROM payments as b JOIN customers as a on a.id=b.customer_id
   where b.id=1;

   SELECT d.name,a.amount,c.currency FROM transactions as b 
   JOIN payments as a on a.id=b.payment_id 
   join currencies as c  on c.id=b.currency_id 
   join customers as d  on  d.id= a.customer_id
   where b.created_at between '2020-10-05' AND '2022-12-10' and b.status='success';


-- 5.Stats for Payment success rates by payment modes, country and currency
   SELECT b.mode_of_payment,b.type_of_mode,c.country,c.currency,count( * ) FROM transactions as a 
   JOIN payment_modes as b on b.id=a.payment_mode_id 
   join currencies as c on c.id=a.currency_id 
   WHERE a.status='success'
   group by a.payment_mode_id,b.mode_of_payment,b.type_of_mode,c.country,c.currency  ORDER by count( * ) desc ;


 --6.Get all the information about the given payment id like number of attempts, browser and OS data, if attempt failed then why?
 select count(*) as attempts,osdata from transactions
 where payment_id=1
 GROUP by osdata

select count(*) as failed_attempts,failed_attempt from transactions
where payment_id=4 and status='failed'
GROUP by failed_attempt


-- 7.List of accounts with most chargebacks and list successful and unsuccessful chargebacks counts
 select a.account as most_chargeback_accounts,count(*) from transactions as a 
 join chargebacks as b on a.id=b.transaction_id
 group by a.account
 order by count( * ) desc

 select a.account as successful_chageback_accounts,count(*) from transactions as a 
 join chargebacks as b on a.id=b.transaction_id
 where b.chargeback_status='success'
 group by a.account
 order by count( * ) desc

 select a.account as unsuccessful_chageback_accounts,count(*) from transactions as a 
 join chargebacks as b on a.id=b.transaction_id
 where b.chargeback_status='failed'
 group by a.account
 order by count( * ) desc

CREATE INDEX idx_account
ON transactions(account);
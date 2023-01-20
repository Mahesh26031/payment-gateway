-- 1.1 no.of payments failed and succesful
    SELECT count(id) FROM transactions WHERE status='successful'
    SELECT count(id) FROM transactions WHERE status='failed'

-- 1.2 total amount captured 
    SELECT sum(amount) from payments where captured=true

-- 1.3 total amount refunded
    SELECT sum(refunded) from payments where refund_status=true

-- 2. List of payment mode with highest success rate
  SELECT b.payment_mode,count( * ) FROM transactions as a JOIN "mode" as b on b.id=a.payment_mode_id 
  group by a.payment_mode_id,a.status,b.payment_mode HAVING a.status='successful' ORDER by count( * ) desc ;

-- 3. Search for payment with customer email or payment id in one query. Add optional filters like date/date range, amount, currency
   SELECT a.name,b.amount FROM customers as a JOIN payments as b on a.id=b.customer_id
   where a.email='kimtim@gmail.com;

   SELECT a.name,b.amount FROM payments as b JOIN customers as a on a.id=b.customer_id
   where b.id=1;

  SELECT a.name,b.amount,c.currency FROM transactions as b JOIN customers as a on a.id=b.customer_id join currency as c  on c.id=b.currency_id
  where b.created_at between '2002-10-05' AND '2018-12-10';

-- 5.Stats for Payment success rates by payment modes, country and currency
  SELECT b.payment_mode,c.country,c.currency,count( * ) FROM transactions as a JOIN "mode" as b on b.id=a.payment_mode_id join currency as c  on c.id=a.currency_id 
  group by a.payment_mode_id,a.status,b.payment_mode,c.country,c.currency HAVING a.status='successful' ORDER by count( * ) desc ;
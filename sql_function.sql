create or replace function comment_increment (count int, row_id int) 
returns void as
$$
  update posts
  set comment_count = comment_count + count
  where id = row_id
$$ 
language sql;
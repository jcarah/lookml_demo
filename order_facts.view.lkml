view: order_facts {

  derived_table: {
    sql: select
          o.id as order_id,
          o.user_id,
          sum(oi.sale_price) as order_total,
          -- sum(oi.sale_price - ii.cost) as margin,
          sum(ii.cost) as cost,
          group_concat(p.item_name) as products,
          group_concat(p.brand) as brands,
          order_number
          from orders o
            left join order_items oi
            on o.id = oi.order_id
            and returned_at is null
            left join inventory_items ii
            on ii.id = oi.inventory_item_id
            left join products p
            on p.id = ii.product_id
            -- hacky way to do row_number() in MySQL
            left join(
              SELECT a.user_id, a.created_at, a.id, count(*) as order_number
                FROM orders a
                JOIN orders b
                ON a.user_id = b.user_id AND a.created_At >= b.created_at
                GROUP BY 1,2,3) foo
            on o.id = foo.id
          group by 1,2
          ;;
  }

######### Dimensions #########
dimension: order_id {
  type: number
  primary_key: yes
  sql: ${TABLE}.order_id ;;
}
dimension: order_total {
  type: number
  sql: ${TABLE}.order_total ;;
}

  dimension: margin {
    type: number
    sql: ${TABLE}.margin ;;
}

dimension: cost {
  type: number
  sql:${TABLE}.cost ;;
}

dimension: order_number {
  type: number
  label: "User's order number"
  sql: ${TABLE}.order_number ;;
}

dimension: first_time_or_repeat_buyer {
  type: string
  sql: case when ${order_number} = 1
        then '1st time buyer'
       else 'Repeat buyer' end;;
}


measure: average_order_vale{
  type: average
  sql: ${order_total} ;;
  drill_fields: [users.user_details*, orders.*]
}

}

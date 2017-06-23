view: order_facts {

  derived_table: {
    sql: select
          o.id as order_id,
          sum(oi.sale_price) as order_total,
          sum(oi.sale_price - ii.cost) as margin,
          sum(ii.cost) as cost,
          group_concat(p.item_name) as products,
          group_concat(p.brand) as brands
          from orders o
          left join order_items oi
          on o.id = oi.order_id
          and returned_at is null
          left join inventory_items ii
          on ii.id = oi.inventory_item_id
          left join products p
          on p.id = ii.product_id
          group by 1
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

measure: average_order_vale{
  type: average
  sql: ${order_total} ;;
  drill_fields: [users.user_details*, orders.*]
}

}

connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore:users {
  join: orders {
    type: left_outer
    sql_on: ${users.id} = ${orders.user_id} ;;
    relationship: one_to_many
  }
  join: order_items {
    type: left_outer
    sql_on: ${orders.id} = ${order_items.order_id} ;;
    relationship: one_to_many
  }
  join: user_facts {
    view_label: "Users"
    type: left_outer
    sql_on: ${users.id} = ${user_facts.user_id} ;;
    relationship: one_to_one
  }
  join: order_facts {
    view_label: "Orders"
    type:  left_outer
    sql_on: ${order_facts.order_id} = ${orders.id} ;;
    relationship: one_to_one
  }
  join: dates {
    type: left_outer
    sql_on: ${orders.created_date} = ${dates.day_date} ;;
    relationship: many_to_one
    }
  join: returns  {
    type: left_outer
    sql_on: ${returns.returned_date} = ${dates.day_date} ;;
    relationship: one_to_many
  }
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

}

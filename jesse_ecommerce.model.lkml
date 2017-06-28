connection: "thelook"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore:users {
  sql_always_where: ${order_items.returned_date} is null ;;
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
}

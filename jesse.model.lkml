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
    view_label: "users"
    type: left_outer
    sql_on: ${users.id} = ${user_facts.user_id} ;;
    relationship: one_to_one
  }
}

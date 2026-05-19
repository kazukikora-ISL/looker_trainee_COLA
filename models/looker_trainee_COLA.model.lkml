connection: "looker_2026trainee"

include: "/views/*.view.lkml"

explore: sales_data {
  join: store_master {
    type: left_outer
    relationship: many_to_one
    sql_on:  ${sales_data.store_id} = ${store_master.store_id} ;;
  }
}

explore: budget_data {
  join: sales_data {
    type: left_outer
    relationship: many_to_one
    sql_on:  ${budget_data.store_id} = ${sales_data.store_id} ;;
  }
}

# 独立したExploreの名前を変更する
explore: store_master {
  label: "店舗マスタ分析"       # 画面に表示される名前
  from: store_master          # 元にするビュー名

  join: budget_data {
    type: left_outer
    relationship: many_to_one
    sql_on:  ${store_master.store_id} = ${budget_data.store_id} ;;
  }
}

explore: product_master {
  join: sales_data {
    type: left_outer
    relationship: one_to_many
    sql_on: ${product_master.product_id} = ${sales_data.product_id} ;;
  }
  join: category_master {
    type: left_outer
    relationship: many_to_one
    sql_on: ${product_master.category_id} = ${category_master.category_id} ;;
  }
}

explore: category_master {
  join: product_inheritance {
    type: left_outer
    relationship: one_to_many
    sql_on:  ${category_master.category_id} = ${product_inheritance.category_id} ;;
  }
}

explore: member_info {
  join: sales_data {
    type: left_outer
    relationship: one_to_many
    sql_on:  ${member_info.customer_id} = ${sales_data.customer_id} ;;
  }
}

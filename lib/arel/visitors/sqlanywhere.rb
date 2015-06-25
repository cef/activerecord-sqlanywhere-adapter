module Arel
  module Visitors
    class SQLAnywhere < Arel::Visitors::ToSql
  
      private

      def visit_Arel_Nodes_SelectStatement o, collector
        limit = fetch_limit(o)
        collector << "SELECT "
        collector << "TOP #{limit} "
        collector << "START AT #{o.offset.expr}" unless o.offset.blank? || o.offset.expr.zero?
        collector = o.cores.inject(collector) { |c,x|
          visit_Arel_Nodes_SelectCore x, c
        }
        if o.orders.any?
          collector << "ORDER BY "
          collector = inject_join o.orders, collector, ", "
        end
        collector = maybe_visit o.lock, collector
      end

      def visit_Arel_Nodes_SelectCore o, collector
        collector = inject_join o.projections, collector, ", "
        froms = false
        if o.source && !o.source.empty?
          froms = true
          collector << " FROM "
          collector = visit o.source, collector
        end

        if o.wheres.any?
          collector << " WHERE "
          collector = inject_join o.wheres, collector, " AND "
        end

        if o.groups.any?
          collector << "GROUP BY "
          collector = inject_join o.groups, collector, ", "
        end
        collector
      end

      def fetch_limit(o)
        if o.limit.expr && o.limit.expr.expr
          limit = o.limit.expr.expr
        else
          limit = 100000
        end
      end
    end
  end
end

Arel::Visitors::VISITORS['sqlanywhere'] = Arel::Visitors::SQLAnywhere
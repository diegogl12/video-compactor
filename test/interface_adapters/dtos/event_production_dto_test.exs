defmodule FoodOrderProducao.InterfaceAdapters.DTOs.EventProductionDTOTest do
use ExUnit.Case, async: false
use Mimic

alias FoodOrderProducao.InterfaceAdapters.DTOs.EventProductionDTO
  alias FoodOrderProducao.Domain.Entities.Production

  setup :set_mimic_global
  setup :verify_on_exit!

  describe "from_json/1" do
    test "successfully converts JSON to DTO" do
      json = ~s({"Id":1,"NumeroPedido":1,"TempoEspera":"00:00:00","DataCriacao":"2025-05-20T00:20:41.380145Z","ClienteId":"00000000-0000-0000-0000-000000009999","PedidoStatus":0,"PagamentoStatus":0,"SacolaId":1,"Produtos":["prod-1","prod-2"]})

      assert {:ok, %EventProductionDTO{order_id: 1, product_ids: ["prod-1", "prod-2"]}} =
               EventProductionDTO.from_json(json)
    end

    test "returns error for invalid JSON" do
      json = ~s({"invalid_json": "missing_fields"})

      assert {:error, "Invalid event production data - unknown fields"} = EventProductionDTO.from_json(json)
    end
  end

  describe "to_domain/1" do
    test "successfully converts DTO to domain entity" do
      dto = %EventProductionDTO{order_id: "order-123", product_ids: ["prod-1", "prod-2"]}

      assert {:ok, %Production{order_id: "order-123", product_ids: ["prod-1", "prod-2"], created_at: _, status: nil}} =
               EventProductionDTO.to_domain(dto)
    end
  end
end

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zkir_i_md_item as select from zi_md_item
association to parent zkir_i_md_header as _Header on $projection.MaterialDocument = _Header.MaterialDocument
                                                  and $projection.DocumentYear = _Header.DocumentYear
{
    key zi_md_item.MaterialDocument,
    key zi_md_item.DocumentYear,
    key zi_md_item.DocumentItem,
    zi_md_item.Material,
    zi_md_item.Plant,
    zi_md_item.StorageLocation,
    zi_md_item.GoodsMovementType,
    zi_md_item.PurchaseOrder,
    zi_md_item.PurchaseOrderItem,
    zi_md_item.GoodsMovementRefDocType,
    zi_md_item.GoodsMovementReasonCode,
     @Semantics.quantity.unitOfMeasure: 'EntryUnit'
    zi_md_item.QuantityInEntryUnit,
    zi_md_item.EntryUnit,
    zi_md_item.IsCompletelyDelivered,
    zi_md_item.lastchangedat,
    zi_md_item.totallastchangedat,
    _Header
}

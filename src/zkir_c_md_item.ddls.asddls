@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.query.implementedBy: 'ABAP:ZCL_MD_ITEM_READ'
define view entity zkir_c_md_item as projection on zkir_i_md_item
{
    key MaterialDocument,
    key DocumentYear,
    key DocumentItem,
    Material,
    Plant,
    StorageLocation,
    GoodsMovementType,
    PurchaseOrder,
    PurchaseOrderItem,
    GoodsMovementRefDocType,
    GoodsMovementReasonCode,
    @Semantics.quantity.unitOfMeasure: 'EntryUnit'
    QuantityInEntryUnit,
    EntryUnit,
    IsCompletelyDelivered,
    lastchangedat,
    totallastchangedat,
    /* Associations */
    _Header : redirected to parent zkir_c_md_header 
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zkir_i_md_header as select from zi_md_header
composition[1..*] of zkir_i_md_item as _Item
{
    
    key zi_md_header.MaterialDocument,
    key zi_md_header.DocumentYear,
    zi_md_header.ReferenceDocument,
    zi_md_header.Supplier,
    zi_md_header.GoodsMovementCode,
    zi_md_header.ReceivingPlant,
    zi_md_header.MaterialDocumentHeaderText,
    zi_md_header.lastchangedat,
    zi_md_header.totallastchangedat,
    _Item
}

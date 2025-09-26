@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.query.implementedBy: 'ABAP:ZCL_MD_READ'
define root view entity zkir_c_md_header 
provider contract transactional_query
as projection on zkir_i_md_header
{
    key MaterialDocument,
    key DocumentYear,
    ReferenceDocument,
    Supplier,
    GoodsMovementCode,
    ReceivingPlant,
    MaterialDocumentHeaderText,
    lastchangedat,
    totallastchangedat,
    /* Associations */
    _Item : redirected to composition child zkir_c_md_item
}

FUNCTION zbapi_goods_mvmt_read.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(MBLNR) TYPE  ZTT_RANGE_MBLNR OPTIONAL
*"     VALUE(MJAHR) TYPE  ZTT_RANGE_MJAHR OPTIONAL
*"  EXPORTING
*"     VALUE(HEADER) TYPE  ZTT_MD_HEADER
*"     VALUE(ITEM) TYPE  ZTT_MD_ITEM
*"     REFERENCE(RETURN) TYPE  ZTT_BAPIRET2
*"----------------------------------------------------------------------
  DATA lw_return LIKE LINE OF return.


  SELECT * FROM zkmd_header  WHERE mblnr IN @mblnr AND mjahr IN @mjahr INTO TABLE @header.
  IF sy-subrc IS NOT INITIAL.
    lw_RETURN-type = 'E'.
    lw_return-message = 'No records found'.
    APPEND lw_return TO return.
  ELSE.
    SELECT * FROM zkmd_item  WHERE mblnr IN @mblnr AND mjahr IN @mjahr INTO TABLE @item.
  ENDIF.



ENDFUNCTION.

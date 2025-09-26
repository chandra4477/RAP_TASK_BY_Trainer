FUNCTION zbapi_goods_mvmt.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(HEADER) TYPE  ZTT_MD_HEADER
*"     VALUE(ITEM) TYPE  ZTT_MD_ITEM
*"  EXPORTING
*"     VALUE(MBLNR) TYPE  ZMBLNR
*"     VALUE(MJAHR) TYPE  ZMJAHR
*"     REFERENCE(RETURN) TYPE  ZTT_BAPIRET2
*"----------------------------------------------------------------------
  DATA lw_return LIKE LINE OF return.
  IF header IS INITIAL.
    IF item IS NOT INITIAL.
      DATA(lv_mblnr) = header[ 1 ]-mblnr.
      DATA(lv_mjahr) = item[ 1 ]-mjahr.
      SELECT * FROM zkmd_header  WHERE mblnr = @lv_mblnr AND mjahr = @lv_mjahr INTO TABLE @header.
    ELSE.
      lw_RETURN-type = 'E'.
      lw_return-message = 'Header data cannot be empty'.
      APPEND lw_return TO return.
    ENDIF.

  ENDIF.
  IF item IS INITIAL AND header IS INITIAL.
    lw_RETURN-type = 'E'.
    lw_return-message = 'Item data cannot be empty'.
    APPEND lw_return TO return.

  ENDIF.
  IF lines( header ) GT 1.
    lw_RETURN-type = 'E'.
    lw_return-message = 'Cannot post more that one document at once'.
    APPEND lw_return TO return.

  ENDIF.
  IF header[ 1 ]-bktxt IS INITIAL OR
     header[ 1 ]-gmcode IS INITIAL OR
     header[ 1 ]-lifnr IS INITIAL OR
    header[ 1 ]-rplant IS INITIAL OR
    header[ 1 ]-xblnr IS INITIAL.

    lw_RETURN-type = 'E'.
    lw_return-message = 'Incomplete Header Data'.
    APPEND lw_return TO return.

  ENDIF.
  IF item IS NOT INITIAL.
    LOOP AT item INTO DATA(lw_item).
      IF lw_item-bwart IS INITIAL OR

        lw_item-ebeln IS INITIAL OR
        lw_item-ebelp IS INITIAL OR
       lw_item-fkimg IS INITIAL OR
        lw_item-gmrdt IS INITIAL OR
        lw_item-grund IS INITIAL OR
        lw_item-lgort IS INITIAL OR
        lw_item-matnr IS INITIAL OR

        lw_item-splant IS INITIAL." OR
*      lw_item-meins IS INITIAL .

        lw_RETURN-type = 'E'.
        lw_return-message = 'Incomplete Item Data'.
        APPEND lw_return TO return.
      ENDIF.

      IF lw_item-bwart NE '101'.
        lw_RETURN-type = 'E'.
        lw_return-message = 'Only Movement Type 101 allowed'.
        APPEND lw_return TO return.
      ENDIF.
    ENDLOOP.

  ENDIF.
  IF header[ 1 ]-gmcode NE '01'.
    lw_return-message = 'Invalid Goods Movement Code'.
    APPEND lw_return TO return.
  ENDIF.


  CLEAR lw_return.
  READ TABLE return INTO lw_return WITH KEY type = 'E'.
  IF sy-subrc IS INITIAL.
    lw_RETURN-type = 'I'.
    lw_return-message = 'No Changes Made'.
    APPEND lw_return TO return.
  ELSE.
    DATA lv_mblnr_found TYPE zmblnr.

    lv_mblnr_found = VALUE #( header[ 1 ]-mblnr OPTIONAL ).
    IF lv_mblnr_found IS INITIAL.
      SELECT MAX( mblnr ) FROM zkmd_header INTO @DATA(v_mblnr).
      IF v_mblnr IS INITIAL.
        v_mblnr = '5000000000'.
      ELSE.
        v_mblnr = v_mblnr + 1.
      ENDIF.
      DATA(datum) = cl_abap_context_info=>get_system_date( ).
      DATA(v_mjahr) =  datum(4).
      header[ 1 ]-mblnr = v_mblnr.
      header[ 1 ]-mjahr = v_mjahr.

    ENDIF.
    mblnr = header[ 1 ]-mblnr.
    mjahr = header[ 1 ]-mjahr.

    MODIFY zkmd_header  FROM TABLE @header.
    MODIFY z08md_header FROM TABLE @header.
    IF item IS NOT INITIAL.
      SELECT MAX( zeile ) FROM zkmd_item  WHERE mblnr EQ @mblnr AND mjahr EQ @mjahr INTO @DATA(v_zeile).
      LOOP AT item ASSIGNING FIELD-SYMBOL(<fs_item>).
        <fs_item>-mblnr = mblnr.
        <fs_item>-mjahr = mjahr.
        IF <fs_item>-zeile IS INITIAL.
          <fs_item>-zeile = v_zeile + 10.
          v_zeile = <fs_item>-zeile.
        ENDIF.
      ENDLOOP.
      MODIFY zkmd_item FROM TABLE @item.
      MODIFY Z08MD_ITEM FROM TABLE @item.
    ENDIF.
    lw_RETURN-type = 'S'.
    lw_return-message = 'Document' && mblnr && ' Year ' && mjahr && ' Posted Successfully'.
    APPEND lw_return TO return.
    mblnr = v_mblnr.
    mjahr = v_mjahr.
  ENDIF.
ENDFUNCTION.

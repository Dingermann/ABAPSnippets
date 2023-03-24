DATA lt_return TYPE TABLE OF bapireturn.

    CALL FUNCTION 'BAPI_MATERIAL_GET_ALL'
      EXPORTING
        material  = CONV matnr18( me->mv_matnr )
        plant     = iv_plant
      IMPORTING
        plantdata = me->ms_plantdata
      TABLES
        return    = lt_return.

    IF line_exists( lt_return[ type = 'E' ] ).
      DATA(ls_return) = lt_return[ type = 'E' ].
      RAISE EXCEPTION TYPE ycx_ewm_ge_material MESSAGE ID ls_return-code(2)
                                               TYPE ls_return-type
                                               NUMBER ls_return-code+2(3)
                                               WITH ls_return-message_v1 ls_return-message_v2
                                                    ls_return-message_v3 ls_return-message_v4.
    ENDIF.

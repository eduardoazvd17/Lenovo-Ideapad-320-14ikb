// VoodooI2C (TPD0) Patch for Lenovo V330-15IKB with ELAN I2C Precision TouchPad.

#ifndef NO_DEFINITIONBLOCK
DefinitionBlock("", "SSDT", 2, "V330", "_I2C", 0)
{
#endif
    External (_HID, FieldUnitObj)    // (from opcode)
    External (_SB_.PCI0.I2C0, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.I2C0.TPD0, DeviceObj)    // (from opcode)
    External (SBFB, FieldUnitObj)    // (from opcode)
    External (SBFF, FieldUnitObj)    // (from opcode)
    External (SBFG, FieldUnitObj)    // (from opcode)
    External (SBFS, FieldUnitObj)    // (from opcode)
    External (SBFX, FieldUnitObj)    // (from opcode)
    External (TPTY, FieldUnitObj)    // (from opcode)
      Scope (_SB.PCI0.I2C0)
    {
        Scope (TPD0)
        {
            Name (SBFX, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x003F
                    }
            })
            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
            {
                If (LEqual (Arg0, ToUUID ("3cdff6f7-4267-4555-ad05-b30a3d8938de") /* HID I2C Device */))
                {
                    If (LEqual (Arg2, Zero))
                    {
                        If (LEqual (Arg1, One))
                        {
                            Return (Buffer (One)
                            {
                                 0x03                                           
                            })
                        }
                        Else
                        {
                            Return (Buffer (One)
                            {
                                 0x00                                           
                            })
                        }
                    }

                    If (LEqual (Arg2, One))
                    {
                        If (LEqual (TPTY, 0x02))
                        {
                            Return (0x20)
                        }

                        If (LEqual (TPTY, One))
                        {
                            Return (One)
                        }

                        If (LEqual (TPTY, 0x03))
                        {
                            Return (One)
                        }
                    }
                }
                ElseIf (LEqual (Arg0, ToUUID ("ef87eb82-f951-46da-84ec-14871ac6f84b")))
                {
                    If (LEqual (Arg2, Zero))
                    {
                        If (LEqual (Arg1, One))
                        {
                            Return (Buffer (One)
                            {
                                 0x03                                           
                            })
                        }
                    }

                    If (LEqual (Arg2, One))
                    {
                        If (LEqual (TPTY, One))
                        {
                            Store ("ELAN0608", _HID)
                            Return (ConcatenateResTemplate (SBFB, SBFG))
                        }

                        If (LEqual (TPTY, 0x02))
                        {
                            Store ("SYNA2B33", _HID)
                            Return (ConcatenateResTemplate (SBFS, SBFG))
                        }

                        If (LEqual (TPTY, 0x03))
                        {
                            Store ("FTCS1000", _HID)
                            Return (ConcatenateResTemplate (SBFF, SBFG))
                        }
                    }

                    Return (Buffer (One)
                    {
                         0x00                                           
                    })
                }
                Else
                {
                    Return (Buffer (One)
                    {
                         0x00                                           
                    })
                }
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (ConcatenateResTemplate (SBFB, SBFX))
            }
        }
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif
//EOF

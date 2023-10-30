//
//  RowView.swift
//  Frame
//
//  Created by Ali Tamoor on 28/10/2023.
//

import SwiftUI

// MARK: - Catagories

struct RowView: View {
    @Binding var row: RoomDetailRowData
    @Binding var data: String
    let actionOptions = ["DEFAULT", "+", "&" , "-", "M" , "I" , "R"]
    let categories = [
        "Permits & Fees",
        "APP : Appliances",
        "CAB : Cabinetry",
        "CLN : Cleaning",
        "CNC : Concrete & Asphalt",
        "CON : Content manipulation",
        "DMO : Demolition",
        "DOR : Doors",
        "DRY : Drywall",
        "ELE : Electric",
        "ELS : Electric Specialty Systems",
        "EQU : Heavy Equipment",
        "EXC : Excavation",
        "FCC : Floor Covering Carpet",
        "FCS : Floor covering - stone",
        "FCW : Floor covering - wood",
        "FCR : Floor Covering - Resilient",
        "FCV : Floor Covering Vinyl",
        "FEE : Permits & Fees",
        "FEN : Fencing",
        "FNC : Finish Carpentry",
        "FNH : Finish Hardware",
        "FPL : Fireplaces",
        "FPS : Fire Protection Systems",
        "FRM : Framing & Rough Carpentry",
        "GLS : Glass, Glazing & Store Fronts",
        "HMR : Hazardous Material Remediation",
        "HVC : HVAC",
        "PLA : Interior lath & plaster",
        "INM : Insulation - Mechanical",
        "INS : Insulation",
        "LAB : Labor Only",
        "LIT : Light Fixtures",
        "MAS : Masonry",
        "MTL : Metal Structures and Components",
        "MPR : Moisture Protection",
        "PLM : Plumbing",
        "PNL : Paneling & Wood Wall Finishes",
        "PNT : Painting",
        "RFG : Roofing",
        "SDG : Siding",
        "SFG : Soffit, Fascia & Gutter",
        "TMP : Temporary Repairs",
        "MBL : Marble - Cultured or Natural",
        "USR : User defined items",
        "WDA : Windows Aluminum",
        "WDP : Windows Sliding Patio Doors",
        "WDT : Window Treatment",
        "WDV : Windows - Vinyl",
        "WDW : Windows Wood",
        "WTR : Water Extraction and Remediation",
        "LIN : Linen & Softgoods",
        "ACT : Acoustical Treatment",
        "CPS : Content: Packout, Handling, Storage",
        "EQC : Equipment - Commercial",
        "LND : Landscaping",
        "ORI : Ornamental Iron",
        "POL : Swimming Pools & Spa",
        "STL : Steel Components",
        "STR : Stairs",
        "STU : Stucco & exterior plaster",
        "TIL : Tile",
        "TMB : Timber Framing",
        "AWN : Awnings & Patio Covers",
        "FCT : Floor covering - ceramic tile",
        "MSD : Mirrors & shower doors",
        "SCF : scaffolding",
        "TBA : Toilet & bath accessories",
        "WDR : Windows reglazing & repair",
        "XST : Exterior structures",
        "WDS : Windows - skylights",
        "VTC : Valuation tool cost"
    ]
    
    // MARK: - Selectors

    let selectors = [
        "1/2WR  :  1/2\" water rock (greenboard) hung, taped ready for texture",
        "1/2WR+  :  1/2\" water rock - hung, taped, floated, ready for paint",
        "110  :  110 volt copper wiring run, box and outlet",
        "110BOX  :  110 volt copper wiring run and box - rough in only",
        "1X12  :  Trim board - 1\" x 12\" - installed (pine)",
        "1X6  :  Trim board - 1\" x 6\" - installed (pine)",
        "1X6H  :  Trim board - 1\" x 6\" - installed (hardwood - oak or =)",
        "220  :  220 volt copper wiring run, box and receptacle",
        "240S  :  3 tab - 25 yr. - comp. shingle roofing - w/out felt",
        "2X12  :  2\" x 12\" lumber (2 BF per LF)",
        "2X4  :  2\" x 4\" lumber (.667 BF per LF)",
        "2X6  :  2\" x 6\" lumber (1 BF per LF)",
        "2X6T  :  2\" x 6\" lumber - treated (1 BF per LF)",
        "3  :  Stairway - 3' wide (8' rise plus joist)",
        "1/2 DRY  :  1/2\" drywall - hung, taped, floated, ready for paint",
        "5/8 DRY  :  5/8\" drywall - hung, taped, floated, ready for paint",
        "4SF  :  Stud wall - 2\" x 4\" - 16\" oc",
        "4SF  :  Tempoary stud wall - 2\" x 4\" - 16\" oc",
        "4SF  :  Temporary stud wall - 2\" x 4\" - 16\" oc",
        "5/8FT  :  5/8\" drywall - hung & fire taped only",
        "6V  :  6-0 6-8 vinyl sliding patio door",
        "ACC  :  Access - face frame & doors",
        "ACCN4+  :  Central air - condenser unit - 4 ton - 14-15 SEER",
        "ACREV  :  Central air cond. system - refrigerant evacuation",
        "ACTW  :  AC unit w/sleeve - through-wall/window - 8,000 BTU",
        "ACTW<  :  AC unit w/sleeve - through-wall/window - 5,000 BTU",
        "AHAC4  :  Air handler - with A-coil - 4 ton",
        "AHHK  :  Air handler hanging kit with drip pan",
        "ALPNT+  :  Aluminum coating - with fiber",
        "APNL+++  :  Wood appliance panel - Deluxe grade",
        "ARCADD  :  Additional cost to hang and finish drywall archway",
        "AV  :  Carpet",
        "AV  :  Ceramic/porcelain tile",
        "AV  :  Clean part of the walls",
        "AV  :  Clean the walls and ceiling",
        "AV  :  Interior door unit complete",
        "AV  :  Light fixture",
        "AV  :  Masonry fireplace & chimney - single story home",
        "AV  :  Mirror - 1/4\" plate glass",
        "AV  :  Tile floor covering",
        "AV+  :  Ceramic/porcelain tile - High grade",
        "AV+  :  Oak flooring - select grade - no finish",
        "AV+  :  Tile floor covering - High grade",
        "AV++  :  Ceramic/porcelain tile - Premium grade",
        "AV++  :  Makeup mirror - lighted - retractable",
        "AV++  :  Wallpaper - Premium grade",
        "AVB  :  Additional labor cost for Berber or patterned carpets",
        "AVB>  :  Ceramic tile - bullnose - 2\" x 6\"",
        "AVPF  :  Pre-finished solid wood flooring",
        "AVPF+  :  Pre-finished solid wood flooring - High grade",
        "B2  :  Paint baseboard - two coats",
        "B2SP  :  Seal & paint baseboard - three coats",
        "B3  :  Baseboard - 3 1/4\"",
        "B5  :  Baseboard - 5 1/4\"",
        "BAC  :  Bath accessory",
        "BAC  :  Clean bath accessory",
        "BAC++  :  Bath accessory - Premium grade",
        "BAL  :  Balustrade",
        "BAL-  :  Balustrade - Standard grade",
        "BAL+  :  Balustrade - High grade",
        "BAL2SP  :  Seal & paint balustrade - three coats",
        "BALS  :  Stain & finish balustrade",
        "BAR2  :  Light bar - 2 lights",
        "BAR6  :  Light bar - 6 lights",
        "BAR8  :  Light bar - 8 lights",
        "BBHST  :  Baseboard heat - steam or hot water",
        "BCEM1/2  :  1/2\" Cement board",
        "BENCH  :  Additional charge to tile a bench seat",
        "BF  :  Bifold door set - Colonist - Double",
        "BF-  :  Bifold door set - lauan/mahogany - Double",
        "BF  :  Paint bifold door set - slab only - 2 coats (per side)",
        "BF++  :  Bifold door set - solid core - half louvered - Double",
        "BF<  :  Bifold door - Colonist - Single",
        "BI  :  Modified bitumen roof",
        "BKS  :  Stain & finish spiral stair landing",
        "BLN1  :  Window blind - PVC - 1\" - 7.1 to 14 SF",
        "BLN1>  :  Window blind - PVC - 1\" - 14.1 to 20 SF",
        "BLN1>>  :  Window blind - PVC - 1\" - 20.1 to 32 SF",
        "BLR>  :  Boiler - natural gas - 165,000 BTU",
        "BMGBF  :  Beam - glulam (per BF)",
        "BP  :  Bypass (sliding) door set - Colonist",
        "BP1  :  Black pipe with fitting and hanger, 1\"",
        "BP3/4  :  Black pipe with fitting and hanger, 3/4\"",
        "BPNL100  :  Breaker panel",
        "BPNL200  :  Breaker panel - 200 amp",
        "BPNL70  :  Breaker panel - 70 amp",
        "BRIDGE  :  Sidewalk Bridge",
        "BRK  :  Brick veneer",
        "BRKL  :  Brick lintel - steel",
        "BRKMD<  :  Circuit breaker - main disconnect - up to 100 amp",
        "BRKP  :  Paint brick",
        "BTF10  :  Batt insulation - 10\" - R30 - paper / foil faced",
        "BTF12  :  Batt insulation - 12\" - R38 - paper / foil faced",
        "BTF4+  :  Batt insulation - 4\" - R13 - paper / foil faced",
        "BTF4++  :  Batt wall insulation - 4\" - R15 - paper / foil faced",
        "BTF6  :  Batt insulation - 6\" - R19 - paper / foil faced",
        "BTF6+  :  Batt ceiling insulation - 6\" - R21 - paper / foil faced",
        "BV3/4  :  Gas valve - brass - 3/4\"",
        "BVNTF  :  Baffle vent - foam",
        "C  :  Casing - 2 1/4\"",
        "C+  :  Casing - 2 1/4\" stain grade",
        "C+  :  Wood window - casement, 12-23 sf, High grade",
        "C<+  :  Wood window - casement, 3-11 sf, High grade",
        "C2SP  :  Seal & paint casing - three coats",
        "CAP  :  Cap Sheet",
        "CBUTTON  :  Door bell/chime button (button only)",
        "CHAN+  :  Chandelier - High grade",
        "CHAN++  :  Chandelier - Premium grade",
        "CHIME  :  Door bell/chime",
        "CLEANF  :  Final Cleaning ",
        "CLNE  :  Ongoing and Daily Clean Up ",
        "CLOS  :  Closet shelf and rod package",
        "CLOS  :  Seal & paint closet shelving - single shelf",
        "CLOSL  :  Closet package - hall/linen (4 shelves 3' wide)",
        "CLOSL  :  Seal & paint closet shelving - linen closet",
        "CLOSLF  :  Seal & paint closet shelving",
        "CLOSP  :  Cedar closet lining - flake board panel",
        "CLOSW-  :  Shelving - wire (vinyl coated)",
        "CM  :  Cove molding - 3/4\"",
        "CM2  :  Paint cove molding - two coats",
        "CNC  :  Clean concrete the ceiling",
        "CNC  :  Clean concrete the floor",
        "CNC  :  Paint concrete the floor",
        "CNCRM  :  Additional labor to remove tile from concrete slab",
        "COL  :  Interior door - Colonist - pre-hung unit",
        "COL8  :  Interior door,- Colonist w/molded detail - pre-hung unit",
        "COLS  :  Stain & finish column",
        "COSM  :  Combination CO/Smoke detector",
        "CPUMP<  :  Circulator pump - cast iron - 1 1/2\" - 1/8 to 1/6 HP",
        "CROWN  :  Add for prefinished light rail molding per LF",
        "CROWN4  :  Add for prefinished 4 piece crown molding",
        "CS  :  Stain & finish casing",
        "CTFL  :  Countertop - flat laid plastic laminate",
        "CTGMS  :  Add on for undermount sink cutout & polish - single basin",
        "CTGMSD  :  Add on for undermount sink cutout & polish - double basin",
        "CTSS  :  Countertop - solid surface",
        "CTSS+  :  Countertop - solid surface - High grade",
        "CTSSBS  :  Backsplash - solid surface - Unattached",
        "CTTLB  :  Add-on for tile backsplash installation",
        "CUTDOR  :  Cut down interior door - slab only",
        "CWN  :  Crown molding - 3 1/4\"",
        "CWN2  :  Paint crown molding - two coats",
        "D  :  Vinyl window - double hung, 9-12 sf",
        "D+  :  Vinyl window - double hung, 9-12 sf - High grade",
        "D<+  :  Vinyl window - double hung, 4-8 sf - High grade",
        "DB  :  Deadbolt",
        "DB+  :  Deadbolt - High grade",
        "DBP4  :  Drilled bottom plate - 2\" x 4\" treated lumber",
        "DCT  :  Ductwork system - hot or cold air - 1200 to 1599 SF home",
        "DCT<<  :  Ductwork system - hot or cold air - up to 900 SF home",
        "DISC30  :  Disconnect box - 30 amp - non fused",
        "DK  :  Stain/finish deck",
        "DOP  :  Door opening (jamb & casing) - 32\"to36\"wide - paint grade",
        "DOR  :  Paint door slab only - 2 coats (per side)",
        "DORDH  :  Door dummy knob - interior",
        "DORH  :  Door knob - interior",
        "DORHX  :  Door lockset - exterior",
        "DORHX+  :  Door lockset - exterior - High grade",
        "DORT  :  Paint door/window trim & jamb - 2 coats (per side)",
        "DORT>  :  Paint door/window trim & jamb - Large - 2 coats (per side)",
        "DRIP  :  Drip edge",
        "DRNL  :  Condensate drain line",
        "DUMP>  :  Dumpster load - Approx. 30 yards, 5-7 tons of debris",
        "DUMP>>  :  Debris Removal",
        "DW  :  Dishwasher connection",
        "DW+  :  Dishwasher - High grade",
        "ECON  :  Equipment connections",
        "ENTRY  :  Entry Door complete",
        "EXJAM  :  Window extension jamb - 11/16\" x 1-23/32\" (4-9/16\" wall)",
        "F  :  Skylight - flat fixed, 9.1 - 10 sf",
        "FACM6  :  Fascia - metal - 6\"",
        "FACST+  :  Fireplace face and hearth - Granite",
        "FACW4-  :  Fascia - 1\" x 2\" - #2 pine",
        "FACW6  :  Fascia - 1\" x 6\" - #1 pine",
        "FAU  :  Sink faucet - Kitchen",
        "FAU-  :  Sink faucet - laundry tub",
        "FAU+  :  Sink faucet - Kitchen - High grade",
        "FAUBA  :  Sink faucet - Bathroom",
        "FAUBA++  :  Sink faucet - Bathroom - Premium grade",
        "FC+  :  False cap - riser & tread - open tread - with return",
        "FCT+  :  Clean floor - tile - Heavy clean",
        "FELT15  :  Roofing felt - 15 lb.",
        "FH  :  Cabinetry - full height unit",
        "FH+++  :  Cabinetry - full height unit - Deluxe grade",
        "FIN  :  Sand & finish wood floor (natural finish)",
        "FINALR  :  Final cleaning - construction - Residential",
        "FINSTP  :  Sand & finish steps and/or risers (natural finish)",
        "FL  :  Fluorescent light fixture",
        "FL14  :  Flashing, 14\" wide",
        "FLCH  :  Chimney flashing - average (32\" x 36\")",
        "FLPIPE  :  Flashing - pipe jack",
        "FNL+  :  Ceiling fan & light - High grade",
        "FR  :  Paint French door slab only - 2 coats (per side)",
        "FRHNG  :  Framing hanger - 2\" x 6\" or 2\" x 8\"",
        "FRHNG>  :  Framing hanger - 2\" x 10\" or 2\" x 12\"",
        "FRHT  :  Framing hurricane tie",
        "FRI82  :  French double door set, 8' - Exterior - pre-hung unit - True divided light",
        "FRX  :  French door - Exterior - pre-hung unit",
        "FRX2  :  French double doors - Exterior - pre-hung unit",
        "FT1/2C4  :  Flexible gas supply line connector - 1/2\" - 25\" to 48\"",
        "FUR2  :  Furring strip - 2\" x 2\"",
        "GADDC  :  Add for glued down wood flooring application over concrete",
        "GD  :  Garbage disposer",
        "GD++  :  Glue down carpet - Premium grade",
        "GDOR  :  Glass fireplace door",
        "GFI  :  Ground fault interrupter (GFI) outlet",
        "GL  :  Add for frosted/etched or beveled glass, per cabinet door",
        "GROUT  :  Regrout tile",
        "GROUT  :  Regrout tile floor",
        "GUTA  :  Gutter / downspout - aluminum - up to 5\"",
        "H410  :  Hip or roof intersection 4/12 slope (hip/val length) 2x10",
        "HCSP1+  :  Duct-free split system - 1 zone - High efficiency",
        "HDR12  :  Header - double 2\" x 12\"",
        "HDR8  :  Header - double 2\" x 8\"",
        "HG++  :  Hanging light fixture - Premium grade",
        "HIGH  :  Additional charge for high roof (2 stories or greater)",
        "HRH+  :  Handrail - detailed profile - hardwood - wall mounted",
        "HRS  :  Stain & finish handrail - wall mounted",
        "HS<  :  Vinyl window, horizontal sliding, 3-11 sf",
        "HS>+  :  Vinyl window, horizontal sliding, 24-32 sf - High grade",
        "HTR5  :  Unit heater - 5kw",
        "HTRU  :  Under-cabinet / kickspace heater - hydronic",
        "HWRAP  :  House wrap (air/moisture barrier)",
        "ICR  :  Intercom - Remote station",
        "IJ9  :  I-joist - 9 1/2\" deep - 1 3/4\" flange",
        "INS3/8  :  Fanfold foam insulation board - 3/8\"",
        "IWS  :  Ice & water barrier",
        "J6SF  :  Joist - floor or ceiling - 2x6 - w/blocking - 16\" oc",
        "J8LF  :  Joist - floor or ceiling - 2x8 - w/blocking",
        "JMB  :  Tile jamb - wrap around",
        "JST+  :  Clean floor or roof joist system - Heavy",
        "JST+  :  Seal floor joist system (shellac)",
        "JST+  :  Seal floor or ceiling joist system (shellac)",
        "JT+  :  Jetted tub - Acrylic - High grade",
        "JTFAU+  :  Jetted tub faucet - High grade",
        "KNPL  :  Cabinet knob or pull",
        "KNPL++  :  Cabinet knob or pull - Premium grade",
        "LAB  :  Awning & Patio Cover Installer - per hour",
        "LAB  :  Carpenter - General Framer - per hour",
        "LAB  :  Carpet Installer - per hour",
        "LAB  :  Cleaning Technician - per hour",
        "LAB  :  Drywall Installer / Finisher - per hour",
        "LAB  :  Electrician - per hour",
        "LAB  :  Finish Carpenter - per hour",
        "LAB  :  General Demolition - per hour",
        "LAB  :  Ornamental Iron Worker - per hour",
        "LAB  :  Painter - per hour",
        "LAB  :  Roofer - per hour",
        "LAB  :  Swimming Pool Installer - per hour",
        "LABER  :  Labor for Demolition ",
        "LABL  :  Roofing - General Laborer - per hour",
        "LAM+  :  Snaplock Laminate - simulated wood flooring - High grade",
        "LAMS  :  Stair nosing - for wood flooring",
        "LIN30  :  Refrigerant lineset - 3/8\" x 3/4\" tubing - up to 30'",
        "LIT  :  Clean light fixture and/or camera",
        "LND  :  Stairway - midpoint landing - (enter SF of landing)",
        "LOW  :  Cabinetry - lower (base) units",
        "LOW+++  :  Cabinetry - lower (base) units - Deluxe grade",
        "LTUB  :  Laundry tub",
        "LVR-  :  Paint half louvered door slab only - 2 coats (per side)",
        "MASKFL  :  Floor protection - self-adhesive plastic film",
        "MATER  :  Material Mobilization ",
        "MBLP  :  Marble or Granite floor - buff & polish",
        "MBXW  :  Wall mount mailbox",
        "MC  :  Medicine cabinet",
        "MC+  :  Medicine cabinet - High grade",
        "MCONT  :  Disconnect with fuse - 50 amp",
        "MEG  :  Megohmmeter check electrical circuits - average residence",
        "METB  :  Meter base - 200 amp",
        "MISC  :  Ceiling Joists",
        "MISC  :  Clean Duct Work",
        "MISC  :  Detach and Reset Signage ",
        "MISC  :  Roof Deck",
        "MNTL-  :  Fireplace mantel - wood beam or shelf only (per LF)",
        "MNTLS  :  Stain & finish wood fireplace mantel",
        "MORTAR  :  Mortar bed for tile floors",
        "MS414  :  Metal studding, 3 5/8\" wide, 16\" OC, 14 gauge",
        "MTA  :  Tile - metal trim - aluminum - up to 9/16",
        "MTL  :  Siding - aluminum (.024 thickness)",
        "MWS+  :  Microwave oven - over range w/built-in hood - High grade",
        "OBS  :  Add on for obscure glass",
        "OH  :  Paint overhead door - 2 coats (per side)",
        "OH8+  :  Overhead door & hardware - 8' x 7' - High grade",
        "OHJ  :  Jamb and trim for overhead door unit",
        "OHO  :  Overhead (garage) door opener",
        "OHS  :  Stain and finish overhead door (per side)",
        "OL  :  Phone, TV, or speaker outlet",
        "OLR  :  Phone/low voltage outlet rough-in",
        "OP  :  Paint door or window opening - 2 coats (per side)",
        "ORI  :  Prime & paint ornamental iron handrail, 36\" to 42\" high",
        "OS  :  Outlet",
        "OS+  :  Outlet - High grade",
        "OSDIM+  :  Dimmer switch - High grade",
        "OSS  :  Switch",
        "OSS+  :  Switch - High grade",
        "P+  :  Vinyl window, picture/fixed, 12-23 sf - High grade",
        "P<+  :  Wood window - picture (fixed), 12-23 sf, High grade",
        "P1X6  :  Siding trim - 1\" x 6\" PVC trim board",
        "PAD  :  Carpet pad",
        "PEG+  :  Patio/pool Enclosure - Full Glass",
        "PLAN  :  Architectural/Drafting fees (Bid Item)",
        "PLK  :  Vinyl plank flooring",
        "PLY++  :  Cabinet panels - side, end, or back - Premium grade",
        "POR  :  Porcelain light fixture",
        "POWOHU  :  Temporary power - overhead hookup",
        "PQ  :  Parquet flooring",
        "PREP  :  Floor preparation for resilient flooring",
        "PREP  :  Prep for new wood flooring",
        "PREP  :  Prep wall for wallpaper",
        "PROTECTION  :  Temporary Protection ",
        "PSNK++  :  Pedestal sink - Premium grade",
        "PT  :  Plumbing/gas line air pressure test",
        "PU  :  Haul debris - per pickup truck load - including dump fees",
        "PUCK  :  Puck light - shallow",
        "PVC1.25  :  PVC schedule 40 conduit, 1 1/4\"",
        "PWASH  :  Clean with pressure/chemical spray",
        "RAD>RS  :  Radiator unit - Large - Detach & reset",
        "RBD1  :  Rigid foam insulation board - 1\"",
        "RBD2  :  Rigid foam insulation board - 2\"",
        "RC  :  Recessed light fixture",
        "RC  :  Recessed light fixture (LED panel)",
        "REWIRE  :  Rewire\\wire - avg. residence - boxes & wiring",
        "RF12LF  :  Rafters - 2x12 - stick frame roof (using rafter length)",
        "RF14  :  Refrigerator - top freezer - 14 to 18 cf",
        "RF18+  :  Refrigerator - top freezer - 18 to 22 cf - High grade",
        "RF6SF  :  Rafters - 2x6 - 16\" OC (3-5/12 Gable, per SF of floor)",
        "RGG  :  Range - freestanding - gas",
        "RGG+  :  Range - freestanding - gas - High grade",
        "RGHFIX  :  Rough in plumbing - per fixture",
        "RIDGC  :  Hip / Ridge cap - composition shingles",
        "RISER  :  Seal & paint stair riser - per side - per LF",
        "RISER+  :  Stair riser - stain grade softwood - up to 4'",
        "ROUGH  :  Comm. Security system - rough-in",
        "ROUGH  :  Rough in plumbing - includes supply and waste lines",
        "SC8+  :  Sprinkler - controller - up to 8 valves - High grade",
        "SCDSF  :  Screw down existing subfloor - eliminate floor squeaks",
        "SD3FR  :  Steel door, 3' x 7' - fire rated",
        "SDC+  :  Custom shower door & partition - 1/2\" glass - frameless",
        "SDOR  :  Shower door",
        "SEALG  :  Grout sealer",
        "SECC+  :  Security system - contact w/wire (per opening)- High grade",
        "SECK+  :  Security system - key pad - High grade",
        "SECP+  :  Security system - control panel - High grade",
        "SFTM  :  Soffit - metal",
        "SFTV  :  Soffit - vinyl",
        "SH1/2  :  Sheathing - plywood - 1/2\" CDX",
        "SH12  :  Shelving - 12\" - in place",
        "SH3/4  :  Sheathing - plywood - 3/4\" CDX",
        "SH5/8  :  Sheathing - plywood - 5/8\" CDX",
        "SHOE  :  Base shoe",
        "SHOE  :  Seal & paint base shoe or quarter round",
        "SHW  :  Seal & paint wood shelving, 12\"- 24\" width",
        "SILLS4  :  Sill seal foam - 4\"",
        "SJACK  :  Temporary shoring post - Screw jack (per day)",
        "SL2X4  :  Sleepers/underlay over concrete 2\" x 4\" sleepers",
        "SL3/4  :  Heat loop - copper with fitting and hanger, 3/4\"",
        "SMOKE  :  Smoke detector",
        "SNDN  :  Wall plaque",
        "SNK  :  Sink - single",
        "SNK+  :  Sink - single - High grade",
        "SNK++  :  Sink - single - Premium grade",
        "SNKKS  :  Kitchen Sink - single basin",
        "SNKKS++  :  Kitchen Sink - single basin - Premium grade",
        "SNKST  :  Sink strainer and drain assembly",
        "SP2  :  Seal/prime then paint part of the walls and ceiling twice (3 coats)",
        "SP2  :  Seal/prime then paint the surface area twice (3 coats)",
        "SP2  :  Seal/prime then paint the walls and ceiling twice (3 coats)",
        "SP2  :  Seal/prime then paint the walls twice (3 coats)",
        "SPIR  :  Spiral staircase - Wood",
        "SROD  :  Shower curtain rod",
        "STD+  :  Clean stud wall - Heavy",
        "STEP  :  Step flashing",
        "STOL  :  Window stool & apron",
        "STPOR  :  Step charge for \"open riser\" carpet installation",
        "STR  :  Paint stair stringer - one side",
        "STREX  :  Stair stringer - exposed - clear-grade wood",
        "STRMD+  :  Storm door assembly - High grade",
        "SUN  :  Sunroom / Garden Room kit - over 180 SF",
        "SUPERR  :  Residential Supervision / Project Management - per hour",
        "SUPERV  :  Field Supervision",
        "SURVC  :  Surveillance camera - color",
        "SWALL+  :  Seal stud wall for odor control (shellac)",
        "SWFAU+  :  Shower faucet - High grade",
        "SWFAU++  :  Shower faucet - Premium grade",
        "SWRB  :  Shower base",
        "SWRCC  :  Tile concrete shower curb - per LF",
        "SWRPAN  :  Shower pan",
        "SWRW  :  Shower light - waterproof fixture",
        "TBAR+  :  Towel bar - High grade",
        "TET5  :  Thermal expansion tank - 4 to 5 gallon",
        "THR  :  Threshold - natural marble",
        "TIPF  :  Building permits",
        "TIPF  :  Certificate of occupancy",
        "TIPF  :  Electric permits",
        "TIPF  :  Fire protection permits",
        "TIPF  :  Mechanical permits",
        "TIPF  :  Plumbing permits",
        "TLT  :  Clean toilet",
        "TLT  :  Temporary toilet (per month)",
        "TLT  :  Toilet",
        "TLT+  :  Toilet - High grade",
        "TLTFL  :  Toilet flange",
        "TLTS  :  Toilet seat",
        "TP+  :  Toilet paper holder - High grade",
        "TR+  :  Towel ring - High grade",
        "TRD+  :  Stair tread - stain grade softwood - up to 4'",
        "TRDS  :  Stain & finish stair tread - per side - per LF",
        "TRIM  :  Seal & paint trim - two coats",
        "TRIMS  :  Limestone trim - Sill",
        "TRIMS  :  Stain & finish trim",
        "TRUNK-  :  Trunk cable - aluminum - 4 wire #2",
        "TRUNK  :  Trunk cable - aluminum - 4 wire 2/0",
        "TS  :  Thermostat",
        "TS  :  Thermostat - electric heat",
        "TSFAU  :  Tub/shower faucet",
        "TSFAU++  :  Tub/shower faucet - Premium grade",
        "TSZ  :  Zone valve",
        "TUB  :  Bathtub",
        "TUB  :  Refinish bathtub",
        "UL  :  Clean floor underlayment / wood subfloor",
        "UL  :  Seal concrete of for odor control",
        "UL  :  Seal underlayment for odor control",
        "UL1/4  :  Underlayment - 1/4\" lauan/mahogany plywood",
        "UL3/4P  :  Underlayment - 3/4\" BC plywood",
        "UP  :  Cabinetry - upper (wall) units",
        "UP  :  Clean cabinetry - upper - inside and out",
        "UP+++  :  Cabinetry - upper (wall) units - Deluxe grade",
        "VAN  :  Vanity",
        "VAN+  :  Vanity - High grade",
        "VANCS  :  Vanity with cultured marble or solid surface top",
        "VENT3  :  Water heater vent - aluminum, 3\"",
        "VENT6+  :  Furnace vent - double wall, 6\"",
        "VENTE  :  Exhaust cap - through roof - 6\" to 8\"",
        "VINYL  :  Siding - vinyl",
        "VMTL  :  Valley metal",
        "VNLS6  :  Vinyl (PVC) fence, 5'- 6' high - full slat",
        "WALL  :  Wall heater",
        "WBOX  :  Washing machine outlet box with valves",
        "WDW  :  Seal & paint wood sidelight (per side)",
        "WDW  :  Seal & paint wood sidelights (per side)",
        "WDW  :  Seal & paint wood window (per side)",
        "WDWRAP  :  Wrap wood window frame & trim with aluminum sheet",
        "WDWRAP>  :  Wrap wood window frame & trim with aluminum sheet - Large",
        "WFRM1  :  Soffit - box framing - 1' overhang",
        "WFRM2  :  Soffit - box framing - 2' overhang",
        "WH60  :  Water heater - 60 gallon - Gas",
        "WL  :  Appliance water line - 1/4\"",
        "WRAPCF  :  Wrap custom beam with aluminum (PER LF)",
        "WRAPCF  :  Wrap custom fascia with aluminum (PER LF)",
        "WRAPGD  :  Wrap wood garage door frame & trim with aluminum (PER LF)",
        "WRAPXD  :  Wrap wood door frame & trim with aluminum (PER LF)",
        "X  :  Exterior light fixture",
        "X+  :  Exterior light fixture - High grade",
        "X++  :  Exterior door - fiberglass / wood w/detail - Premium grade",
        "X++  :  Exterior light fixture - Premium grade",
        "XFAU  :  Exterior faucet / hose bibb",
        "XOS  :  Exterior outlet or switch",
        "XOSC  :  Exterior outlet or switch cover",
        "XSL+  :  Ext. door sidelite - pre-attached - High grade",
    ]
    
    @Binding var fieldTitle: String
    @State private var categorySearchText: String = ""
    @State private var selectorSearchText: String = ""
    @State private var isEditingDescription: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @State private var currentField: FieldToFill = .category
    enum FieldToFill {
        case category
        case selector
        case quantity
//        case action
    }
    

    var filteredCategories: [String] {
        categories.filter { $0.lowercased().contains(categorySearchText.lowercased()) || categorySearchText.isEmpty }
    }
    
    var filteredSelectors: [String] {
        selectors.filter { $0.lowercased().contains(selectorSearchText.lowercased()) || selectorSearchText.isEmpty }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Category")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Search Category", text: $categorySearchText, onEditingChanged: { _ in
                    fieldTitle = "Category"
                    self.currentField = .category })
                    .frame(height: 50)
                    .padding(5)
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 0.5))

                Picker("Category", selection: $row.category) {
                    ForEach(filteredCategories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Selector")
                    .font(.caption)
                    .foregroundColor(.gray)
                TextField("Search Selector", text: $selectorSearchText, onEditingChanged: { _ in
                    fieldTitle = "Selector"

                    self.currentField = .selector
                })
                    .frame(height: 50)
                    .padding(5)
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(5)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 0.5))
                    .onChange(of: data) { newValue in
                        if !data.isEmpty {
                            switch currentField {
                            case .category:
                                categorySearchText = data
                            case .selector:
                                selectorSearchText = data
                            case .quantity:
                                row.quantityAndDescription = data
                            }
                        }
                    }
                
                Picker("Selector", selection: $row.selector) {
                    ForEach(filteredSelectors, id: \.self) { selector in
                        Text(selector).tag(selector)
                    }
                }
                .onChange(of: row.selector, perform: { value in
                    // Update the TextField value when the selected option changes
                    selectorSearchText = row.selector
                })
                .onChange(of: row.category, perform: { value in
                    // Update the TextField value when the selected option changes
                    categorySearchText = row.category
                })
                .pickerStyle(MenuPickerStyle())
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Action")
                    .font(.caption)
                    .foregroundColor(.gray)
                Picker("Action", selection: $row.action) {
                    ForEach(actionOptions, id: \.self) { option in
                        Text(option).tag(option)
                    }
                    
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Quantity & Description")
                    .font(.caption)
                    .foregroundColor(.gray)
                ZStack(alignment: .topLeading) {
                    if row.quantityAndDescription.isEmpty && !isEditingDescription {
                        Text("Enter Quantity & Description")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 4)
                    }
                    TextEditor(text: $row.quantityAndDescription)
                        .onTapGesture {
                            isEditingDescription = true
                        }
                        .focused($isTextFieldFocused, equals: true)
                        .onChange(of: isTextFieldFocused) { newValue in
                            fieldTitle = "Quantity & Description"
                            if newValue {
                                self.currentField = .quantity
                            }
                        }
                    
                }
                .padding(5)
                .background(Color(UIColor.tertiarySystemFill))
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 0.5))
                .frame(height: 100)
            }

        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
    
    var currentFieldTitle: String {
        switch self.currentField {
        case .category:
            fieldTitle = "Category"
            return "Category"
        case .selector:
            fieldTitle = "Selector"
            return "Selector"
        case .quantity:
            fieldTitle = "Quantity & Description"
            return "Quantity & Description"
        }
    }
}

//#Preview {
//    RowView()
//}

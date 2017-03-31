from opentrons import containers, instruments


p10rack = containers.load('tiprack-200ul', 'A1', 'tiprack')
plate = containers.load('96-PCR-flat', 'C1', 'plate')
trough = containers.load('trough-12row', 'C3', 'trough')
trash = containers.load('point', 'A1', 'trash')

p10 = instruments.Pipette(
    name="p10",
    trash_container=trash,
    tip_racks=[p10rack],
    max_volume=10,
    axis="b"
)




well = ['A1', 'B1']
for i in well:
	p10.pick_up_tip(p10rack['A2'])
	p10.aspirate(10, trough[i])  # first row in trough
	p10.dispense(0.5, plate['A1'])      # first well in plate
	p10.dispense(1, plate['A2'])        # second well in plate
	p10.dispense(1.5, plate['A3'])      # third well in plate
	p10.dispense(2, plate['A4'])        # fourth well in plate
	p10.dispense(2.5, plate['A5'])        # fourth well in plate
	p10.dispense(2.5, plate['A6'])        # fourth well in plate
	p10.drop_tip()


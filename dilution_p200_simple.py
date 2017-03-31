from opentrons import containers, instruments


p200rack = containers.load('tiprack-200ul', 'A1', 'tiprack')
plate = containers.load('96-PCR-flat', 'C1', 'plate')
trough = containers.load('trough-12row', 'C3', 'trough')
trash = containers.load('point', 'A1', 'trash')

p200 = instruments.Pipette(
    name="p200",
    trash_container=trash,
    tip_racks=[p200rack],
    max_volume=200,
    axis="b"
)

p200.pick_up_tip(p200rack['A1'])

p200.aspirate(100, trough['A1'])  # first row in trough
p200.dispense(100, plate['F1'])

p200.aspirate(25, trough['A3'])  # first row in trough
p200.dispense(25, plate['F1'])

p200.aspirate(75, trough['A5'])  # first row in trough
p200.dispense(75, plate['F1'])

p200.aspirate(100, trough['A5'])  # first row in trough
p200.dispense(100, plate['F2'])

p200.aspirate(100, trough['A5'])  # first row in trough
p200.dispense(100, plate['F3'])

for i in range(3):
	p200.aspirate(100, plate['F1'])  # first row in trough
	p200.dispense(100, plate['F1'])

p200.aspirate(100, plate['F1'])  # first row in trough
p200.dispense(100, plate['F2'])

for i in range(3):
	p200.aspirate(100, plate['F2'])  # first row in trough
	p200.dispense(100, plate['F2'])

p200.aspirate(100, plate['F2'])  # first row in trough
p200.dispense(100, plate['F3'])

for i in range(3):
	p200.aspirate(100, plate['F3'])  # first row in trough
	p200.dispense(100, plate['F3'])

p200.drop_tip(p200rack['A1'])

#well = ['A1', 'B1']
#well = ['A1']
#for i in well:
	#p200.pick_up_tip(p200rack['A1'])
	#p200.aspirate(100, trough[i])  # first row in trough
	#p200.dispense(100, plate['A1'])      # first well in plate
	#p200.dispense(2.5, plate['A2'])        # second well in plate
	#p200.dispense(3, plate['A3'])      # third well in plate
	#p200.dispense(2.5, plate['A4'])        # fourth well in plate
#	p200.drop_tip()


from opentrons import containers, instruments


p100rack = containers.load('tiprack-200ul', 'A1', 'tiprack')
plate = containers.load('96-PCR-flat', 'C1', 'plate')
trough = containers.load('trough-12row', 'C3', 'trough')
trash = containers.load('point', 'A1', 'trash')

p100 = instruments.Pipette(
    name="p100",
    trash_container=trash,
    tip_racks=[p100rack],
    max_volume=100,
    axis="b"
)

p100.pick_up_tip(p100rack['A1'])

p100.aspirate(50, trough['A1'])  # first row in trough
p100.dispense(50, plate['B1'])

p100.aspirate(50, trough['A1'])  # first row in trough
p100.dispense(50, plate['B2'])

p100.aspirate(50, trough['A1'])  # first row in trough
p100.dispense(50, plate['B3'])

p100.aspirate(50, trough['A1'])  # first row in trough
p100.dispense(50, plate['B4'])

p100.aspirate(50, trough['A1'])  # first row in trough
p100.dispense(50, plate['B1'])


for i in range(3):
	p100.aspirate(100, plate['B1'])  # first row in trough
	p100.dispense(100, plate['B1'])

p100.aspirate(50, plate['B1'])  # first row in trough
p100.dispense(50, plate['B2'])

for i in range(3):
	p100.aspirate(100, plate['B2'])  # first row in trough
	p100.dispense(100, plate['B2'])

p100.aspirate(50, plate['B2'])  # first row in trough
p100.dispense(50, plate['B3'])

for i in range(3):
	p100.aspirate(100, plate['B3'])  # first row in trough
	p100.dispense(100, plate['B3'])

p100.aspirate(50, plate['B3'])  # first row in trough
p100.dispense(50, plate['B4'])

for i in range(3):
	p100.aspirate(100, plate['B4'])  # first row in trough
	p100.dispense(100, plate['B4'])

p100.drop_tip(p100rack['A1'])
#well = ['B1', 'B1']
#well = ['B1']
#for i in well:
	#p100.pick_up_tip(p100rack['B1'])
	#p100.aspirate(50, trough[i])  # first row in trough
	#p100.dispense(50, plate['B1'])      # first well in plate
	#p100.dispense(2.5, plate['B2'])        # second well in plate
	#p100.dispense(3, plate['B3'])      # third well in plate
	#p100.dispense(2.5, plate['B4'])        # fourth well in plate
#	p100.drop_tip()


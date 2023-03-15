from thingly.models.thing import Thing


def test_things(db):
    thing = Thing()
    db.session.add(thing)
    db.session.commit()

    # basic checks to see whether fields got populated
    assert thing.id is not None
    assert thing.created_at is not None
    assert thing.last_modified is not None

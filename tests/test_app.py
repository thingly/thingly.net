import json


def test_index(client):
    response = client.get("/")

    assert response is not None
    assert response.status_code == 200


def test_dice(client):
    response = client.get("/api/dice")

    assert response is not None
    assert response.status_code == 200

    result = json.loads(response.data)
    assert isinstance(result, dict)
    assert "data" in result
    rolls = result["data"]
    assert len(rolls) == 1
    assert 1 <= rolls[0] <= 6


def test_dice_n(client):
    response = client.get("/api/dice/3")

    assert response is not None
    assert response.status_code == 200

    result = json.loads(response.data)
    assert isinstance(result, dict)
    assert "data" in result
    rolls = result["data"]
    assert len(rolls) == 3
    for roll in rolls:
        assert 1 <= roll <= 6


def test_dice_n_d(client):
    response = client.get("/api/dice/5/12")

    assert response is not None
    assert response.status_code == 200

    result = json.loads(response.data)
    assert isinstance(result, dict)
    assert "data" in result
    rolls = result["data"]
    assert len(rolls) == 5
    for roll in rolls:
        assert 1 <= roll <= 12

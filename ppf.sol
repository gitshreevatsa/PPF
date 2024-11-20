// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PixelPumpFun {
    struct Coordinates {
        uint32 x;
        uint32 y;
    }

    struct Pixel {
        address owner;
        uint256 price;
        uint256 numberOfTransfers;
        uint256 r;
        uint256 g;
        uint256 b;
    }

    Pixel[][] public board;

    function getPrice(Coordinates calldata topLeft, Coordinates calldata bottomRight) public view returns (uint256) {
        validate(topLeft);
        validate(bottomRight);
        require(topLeft.x <= bottomRight.x && topLeft.y <= bottomRight.y);

        uint256 totalPrice = 0;

        for (uint256 x = topLeft.x; x <= bottomRight.x; x++) {
            for (uint256 y = topLeft.y; y <= board[x].length; y++) {
                Pixel storage pixel = board[x][y];
                totalPrice += pixel.price;
            }
        }

        return totalPrice;
    }

    function validate(Coordinates calldata point) private view {
        require(
            point.x >= 0 && point.x <= board.length
            && point.y >= 0 && point.y <= board[0].length,
            "point value is invalid"
        );
    }
}
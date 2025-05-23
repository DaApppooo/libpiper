.PHONY: clean docker

ifeq ($(OS),Windows_NT)
	CMAKE_FLAGS = -G 'NMake Makefiles' "-DCMAKE_C_COMPILER=$((Get-Command gcc).source)" "-DCMAKE_CXX_COMPILER=$((Get-Command g++).source)"
else
	CMAKE_FLAGS =
endif

all:
	cmake -Bbuild -DCMAKE_INSTALL_PREFIX=install $(CMAKE_FLAGS)
	cmake --build build $(CMAKE_FLAGS) --config Release
	# cd build && ctest $(CMAKE_FLAGS) --config Release
	cmake --install build  $(CMAKE_FLAGS)

docker:
	docker buildx build . --platform linux/amd64,linux/arm64,linux/arm/v7 --output 'type=local,dest=dist'

clean:
	rm -rf build install dist
